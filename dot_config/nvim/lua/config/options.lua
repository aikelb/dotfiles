-- Options are automatically loaded before lazy.nvim startup
-- Default options: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua

local opt = vim.opt

-- Tabs, shown as 2 columns (LazyVim defaults to 2 spaces)
opt.expandtab = false
opt.tabstop = 2
opt.softtabstop = 2
opt.shiftwidth = 0 -- follow tabstop

-- Defold and other game/web file types
vim.filetype.add({
  extension = {
    -- Defold: Lua scripts
    script = "lua",
    gui_script = "lua",
    render_script = "lua",
    editor_script = "lua",
    -- Defold: shaders
    vp = "glsl",
    fp = "glsl",
    vsh = "glsl",
    fsh = "glsl",
    -- Defold: project and data files
    project = "ini",
    buffer = "json",
    script_api = "yaml",
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
    manifest = "protobuf",
    appmanifest = "protobuf",
    -- Eleventy templates
    njk = "html",
  },
})
