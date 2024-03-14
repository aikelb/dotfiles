require "nvchad.mappings"

local map = vim.keymap.set

map("n", ";", ":", {desc = "CMD enter command mode"})

map("n", "<leader>fm", function ()
  require("conform").format()
end, {desc = "File Format with conform"})

map("i", "jk", "<ESC>", { desc = "escape insert mode"})

map("n", "<leader>e", "<cmd>lua vim.diagnostic.open_float()<CR>", {desc = "Floating Diagnostic"})
map("n", "gd", "<cmd>Telescope lsp_definitions<cr>", {desc = "Go to Definition"})

map ("v", ">", ">gv", {desc = "indent"} )
