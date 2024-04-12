local autocmd = vim.api.nvim_create_autocmd

-- Auto resize panes when resizing nvim window
autocmd("VimResized", {
	pattern = "*",
	command = "tabdo wincmd =",
})

-- File types
-- autocmd({"BufNewFile", "BufRead"}, {
-- 	pattern = "*.script,*.gui_script",
-- 	command = "setfiletype lua",
-- })

autocmd({"BufNewFile", "BufRead"}, {
	pattern = "*.fp,*.vp,*.vsh,*.fsh",
	command = "setfiletype glsl",
})

