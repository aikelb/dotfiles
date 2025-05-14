return {
  'echasnovski/mini.nvim',
  event = 'VimEnter',
  dependencies = {
    -- Asegúrate de que nvim-web-devicons esté listado si no lo está en otro lugar
    -- 'nvim-tree/nvim-web-devicons',
  },
  config = function()
    local statusline = require 'mini.statusline'
    local minigit = require 'mini.git'

    -- *** Función Helper para obtener colores de Highlight Groups ***
    -- Intenta obtener un color (fg o bg) de un grupo de highlight.
    -- Devuelve un color hexadecimal (#RRGGBB) o el valor por defecto.
    local function get_hl_color(group, type, default_hex)
      local hl_info = vim.fn.hlexists(group) == 1
          and vim.api.nvim_get_hl_by_name(group, true)
        or nil
      if hl_info and hl_info[type] then
        -- El color viene como un entero decimal, convertir a hexadecimal
        return string.format('#%06x', hl_info[type])
      end
      -- Si no se encuentra o no tiene el tipo (fg/bg), usar el default
      -- Asegurarse de que el default también esté en formato #RRGGBB
      local default_val =
        vim.fn.synIDattr(vim.fn.synIDtrans(vim.fn.hlID(default_hex)), type .. '#')
      if default_val ~= '' then
        return default_val
      end
      -- Fallback final si todo falla
      return default_hex -- Asume que el default ya es un hex válido si la conversión falla
    end

    -- *** Obtener colores dinámicamente del tema actual ***
    -- Mapea nombres semánticos a grupos de highlight comunes que los temas suelen definir.
    -- Proporciona colores de fallback razonables (basados en tokyonight como referencia).
    local colors = {
      bg = get_hl_color('Normal', 'background', '#1a1b26'),
      fg = get_hl_color('Normal', 'foreground', '#c0caf5'),
      bg_dark = get_hl_color('StatusLineNC', 'background', '#16161e'), -- Fondo inactivo
      fg_dark = get_hl_color('StatusLineNC', 'foreground', '#a9b1d6'), -- Texto inactivo/tenue
      bg_highlight = get_hl_color('StatusLine', 'background', '#292e42'), -- Fondo activo/seleccionado
      fg_gutter = get_hl_color('LineNr', 'foreground', '#3b4261'), -- Color tenue para números de línea/separadores

      -- Colores semánticos comunes
      blue = get_hl_color('DiagnosticInfo', 'foreground', '#7aa2f7'), -- Info, Funciones
      cyan = get_hl_color('DiagnosticHint', 'foreground', '#7dcfff'), -- Hints, Constantes
      green = get_hl_color('String', 'foreground', '#9ece6a'), -- Strings, Añadidos
      purple = get_hl_color('Statement', 'foreground', '#bb9af7'), -- Keywords, Statements
      red = get_hl_color('DiagnosticError', 'foreground', '#f7768e'), -- Errores, Eliminados
      orange = get_hl_color('DiagnosticWarn', 'foreground', '#ff9e64'), -- Warnings (a veces naranja)
      yellow = get_hl_color('DiagnosticWarn', 'foreground', '#e0af68'), -- Warnings (a veces amarillo), Modificados

      -- Colores específicos derivados
      terminal_black = get_hl_color('Comment', 'foreground', '#414868'), -- Usar color de comentario como negro terminal
    }
    -- Derivar colores de Git y Diagnósticos de los semánticos
    colors.git_add = colors.green
    colors.git_change = colors.yellow -- O usa colors.orange si prefieres
    colors.git_delete = colors.red
    colors.diag_error = colors.red
    colors.diag_warn = colors.yellow -- O usa colors.orange
    colors.diag_info = colors.blue
    colors.diag_hint = colors.cyan

    -- Configurar colores para que coincidan con el tema actual
    local set_hl = function(group, opts)
      -- Asegurarse de que los colores estén en formato #RRGGBB para set_hl
      local final_opts = vim.deepcopy(opts) -- Copiar para no modificar la tabla original
      if final_opts.fg and not string.match(final_opts.fg, '^#') then
        final_opts.fg = colors[final_opts.fg]
      end
      if final_opts.bg and not string.match(final_opts.bg, '^#') then
        final_opts.bg = colors[final_opts.bg]
      end
      vim.api.nvim_set_hl(0, group, final_opts)
    end

    -- Aplicar los colores dinámicos a los grupos de MiniStatusline
    set_hl('MiniStatuslineModeNormal', { fg = 'bg', bg = 'blue', bold = true })
    set_hl('MiniStatuslineModeInsert', { fg = 'bg', bg = 'green', bold = true })
    set_hl('MiniStatuslineModeVisual', { fg = 'bg', bg = 'purple', bold = true })
    set_hl('MiniStatuslineModeReplace', { fg = 'bg', bg = 'red', bold = true })
    set_hl('MiniStatuslineModeCommand', { fg = 'bg', bg = 'yellow', bold = true })
    set_hl('MiniStatuslineModeOther', { fg = 'bg', bg = 'cyan', bold = true })

    set_hl('MiniStatuslineDevinfo', { fg = 'fg_dark', bg = 'bg_dark' })
    set_hl('MiniStatuslineFilename', { fg = 'fg', bg = 'bg_dark' })
    set_hl('MiniStatuslineFileinfo', { fg = 'fg_dark', bg = 'bg_highlight' })
    set_hl('MiniStatuslineInactive', { fg = 'fg_gutter', bg = 'bg_dark' })

    set_hl('MiniStatuslineGitAdd', { fg = 'git_add', bg = 'bg_highlight' })
    set_hl('MiniStatuslineGitChange', { fg = 'git_change', bg = 'bg_highlight' })
    set_hl('MiniStatuslineGitDelete', { fg = 'git_delete', bg = 'bg_highlight' })

    set_hl(
      'MiniStatuslineDiagnosticError',
      { fg = 'diag_error', bg = 'bg_highlight' }
    )
    set_hl('MiniStatuslineDiagnosticWarn', { fg = 'diag_warn', bg = 'bg_highlight' })
    set_hl('MiniStatuslineDiagnosticInfo', { fg = 'diag_info', bg = 'bg_highlight' })
    set_hl('MiniStatuslineDiagnosticHint', { fg = 'diag_hint', bg = 'bg_highlight' })

    local function section_git_custom(args)
      args = args or {}
      local ok, branch = pcall(minigit.get_branch)
      if not ok or branch == '' then
        return ''
      end

      local hunks_ok, hunks = pcall(minigit.get_hunks)
      local added = (hunks_ok and hunks.added) or 0
      local changed = (hunks_ok and hunks.changed) or 0
      local removed = (hunks_ok and hunks.removed) or 0

      local status_parts = {}
      if added > 0 then
        table.insert(
          status_parts,
          statusline.hl('MiniStatuslineGitAdd', string.format('+%d', added))
        )
      end
      if changed > 0 then
        table.insert(
          status_parts,
          statusline.hl('MiniStatuslineGitChange', string.format('~%d', changed))
        )
      end
      if removed > 0 then
        table.insert(
          status_parts,
          statusline.hl('MiniStatuslineGitDelete', string.format('-%d', removed))
        )
      end

      local status_str = table.concat(status_parts, ' ')
      local result = ' ' .. branch

      if status_str ~= '' then
        result = result .. ' (' .. status_str .. ')'
      end

      if args.trunc_width and vim.fn.strwidth(result) > args.trunc_width then
        result = vim.fn.strcharpart(result, 0, args.trunc_width - 1) .. '…'
      end

      return result
    end

    statusline.setup {
      use_icons = vim.g.have_nerd_font or false,
      set_vim_settings = true,
      content = {
        active = function()
          local mode, mode_hl = statusline.section_mode { trunc_width = 120 }
          local git = section_git_custom { trunc_width = 100 }
          local filename = statusline.section_filename { trunc_width = 140 }
					local diagnostics = statusline.section_diagnostics({ trunc_width = 80 })
          local fileinfo = statusline.section_fileinfo { trunc_width = 120 }
          local location = statusline.section_location { trunc_width = 75 }
          local lsp_clients_str = ''
          local clients = vim.lsp.get_clients { bufnr = 0 }
          if #clients > 0 then
            local client_names = {}
            for _, client in ipairs(clients) do
              table.insert(client_names, client.name)
            end
            lsp_clients_str = ' ' .. table.concat(client_names, ', ')
          end
          local sep = '%='
          local pipe = '│'

          return statusline.combine_groups {
            { hl = mode_hl, strings = { ' ' .. mode .. ' ' } },
            {
              hl = 'MiniStatuslineDevinfo',
              strings = { git ~= '' and (' ' .. git .. ' ') or '' },
            },
            {
              hl = 'MiniStatuslineFilename',
              strings = { filename ~= '' and (pipe .. ' ' .. filename .. ' ') or '' },
            },
            { hl = 'MiniStatuslineNC', strings = { sep } },
            {
              hl = 'MiniStatuslineDevinfo',
              strings = { lsp_clients_str ~= '' and (lsp_clients_str .. ' ') or '' },
            },
            {
              hl = 'MiniStatuslineDevinfo',
              strings = { diagnostics ~= '' and (diagnostics .. ' ') or '' },
            },
            {
              hl = 'MiniStatuslineFileinfo',
              strings = { fileinfo ~= '' and (pipe .. ' ' .. fileinfo .. ' ') or '' },
            },
            {
              hl = mode_hl,
              strings = { location ~= '' and (pipe .. ' ' .. location .. ' ') or '' },
            },
          }
        end,
        inactive = function()
          local filename = statusline.section_filename { trunc_width = 140 }
          local fileinfo = statusline.section_fileinfo { trunc_width = 120 }
          return statusline.combine_groups {
            { hl = 'MiniStatuslineInactive', strings = { ' ' .. filename } },
            { hl = 'MiniStatuslineInactive', strings = { '%=' } },
            { hl = 'MiniStatuslineInactive', strings = { fileinfo .. ' ' } },
          }
        end,
      },
    }

    -- Sobrescribir secciones (sin cambios, usarán los highlights dinámicos)
    ---@diagnostic disable-next-line: duplicate-set-field
    statusline.section_location = function()
      return '%2l:%-2v (%3p%%)'
    end

    ---@diagnostic disable-next-line: duplicate-set-field
    statusline.section_filename = function(args)
      args = args or {}
      local bufname = vim.api.nvim_buf_get_name(0)
      local filename = bufname ~= '' and vim.fn.fnamemodify(bufname, ':t')
        or '[Sin Nombre]'
      local path = bufname ~= '' and vim.fn.fnamemodify(bufname, ':.') or ''
      local icon = ''
      local ok, devicons = pcall(require, 'nvim-web-devicons')
      if ok and devicons then
        local ext = vim.fn.fnamemodify(filename, ':e')
        local devicon, _ = devicons.get_icon(filename, ext, { default = true })
        if devicon then
          icon = devicon .. ' '
        end
      end
      local display_name = path
      if args.trunc_width and vim.fn.strwidth(display_name) > args.trunc_width then
        display_name = vim.fn.pathshorten(display_name)
      end
      if display_name == '' then
        display_name = filename
      end
      local modified = vim.bo.modified and ' ●' or ''
      local readonly = (vim.bo.readonly or not vim.bo.modifiable) and ' ' or ''
      return icon .. display_name .. modified .. readonly
    end
  end,
}
