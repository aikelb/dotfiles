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
