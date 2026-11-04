-- Personal additions on top of LazyVim.
-- Extras (neo-tree, markdown, colors, projects, languages) are enabled in lazyvim.json — manage them with :LazyExtras.

return {
  -- Neo-tree: hide project noise
  {
    "nvim-neo-tree/neo-tree.nvim",
    opts = {
      close_if_last_window = true,
      window = { width = 30 },
      filesystem = {
        filtered_items = {
          hide_dotfiles = true,
          hide_gitignored = true,
          hide_by_name = { "node_modules", ".defold", ".vscode" },
          never_show = { ".DS_Store", "thumbs.db" },
        },
      },
    },
  },

  -- Code screenshots (:Silicon), needs the `silicon` CLI
  {
    "michaelrommel/nvim-silicon",
    cmd = "Silicon",
    opts = {
      font = "FiraCode Nerd Font=34",
      theme = "Dracula",
      background = "#94e2d5",
      to_clipboard = true,
      gobble = true,
    },
  },

  -- Defold shaders and protobuf data files
  {
    "nvim-treesitter/nvim-treesitter",
    opts = { ensure_installed = { "glsl", "proto", "ini" } },
  },
}
