---@type MappingsTable
local M = {}

M.general = {
  n = {
    [";"] = { ":", "enter command mode", opts = { nowait = true } },

    --  format with conform
    ["<leader>fm"] = {
      function()
        require("conform").format()
      end,
      "formatting",
    },
    ["<leader>e"] = { "<cmd>lua vim.diagnostic.open_float()<CR>", "Floating Diagnostic" },
    ['gd'] = {"<cmd>Telescope lsp_definitions<cr>", "Go to Definition"}
  },
  v = {
    [">"] = { ">gv", "indent" },
  },
  i = {},
}

-- more keybinds!

return M
