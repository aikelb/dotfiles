local opt = vim.opt

-- Use tabs
opt.autoindent = true
opt.expandtab = false
opt.tabstop = 2
opt.shiftwidth = 2
opt.softtabstop = 0

vim.filetype.add({
	extension = {
		script = "lua",
		gui_script = "lua",
		render_script = "lua",
		editor_script = "lua",
		vp = "glsl",
		fp = "glsl",
	},
})

