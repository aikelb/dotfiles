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
		buffer = "json",
		go = "protobuf",
		animationset = "protobuf",
		atlas = "protobuf",
		camera = "protobuf",
		collection = "protobuf",
		collectionfactory = "protobuf",
		collectionproxy = "protobuf",
		collisionobject = "protobuf",
		display_profiles = "protobuf",
		factory = "protobuf",
		gamepads = "protobuf",
		gui = "protobuf",
		input_binding = "protobuf",
		label = "protobuf",
		material = "protobuf",
		mesh = "protobuf",
		model = "protobuf",
		particlefx = "protobuf",
		render = "protobuf",
		sound = "protobuf",
		spinemodel = "protobuf",
		spinescene = "protobuf",
		sprite = "protobuf",
		texture_profiles = "protobuf",
		tilemap = "protobuf",
		tilesource = "protobuf",
		njk = "html",
	},
})

