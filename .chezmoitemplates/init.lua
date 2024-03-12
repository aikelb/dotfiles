local autocmd = vim.api.nvim_create_autocmd

-- Auto resize panes when resizing nvim window
autocmd("VimResized", {
  pattern = "*",
  command = "tabdo wincmd =",
})

-- Lua lsp for script files
autocmd("BufNewFile", {
  pattern = "*.script,*.gui_script",
  command = "setfiletype lua",
})
autocmd("BufRead", {
  pattern = "*.script,*.gui_script",
  command = "setfiletype lua",
})

-- hlsl for defold shader files
autocmd("BufNewFile", {
  pattern = "*.fp,*.vp",
  command = "setfiletype hlsl",
})
autocmd("BufRead", {
  pattern = "*.fp,*.vp",
  command = "setfiletype hlsl",
})
-- vim.cmd("autocmd! BufNewFile,BufRead *.script setfiletype lua")

-- Use tabs
vim.opt.autoindent = true
vim.opt.expandtab = false
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.softtabstop = 0
