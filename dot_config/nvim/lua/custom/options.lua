local o = vim.o

vim.opt.termguicolors = true

-- Use tabs
o.autoindent = true
o.expandtab = false
o.tabstop = 2
o.shiftwidth = 2
o.softtabstop = 0

vim.filetype.add {
  extension = {
    project = 'ini',
    script = 'lua',
    gui_script = 'lua',
    render_script = 'lua',
    editor_script = 'lua',
    vp = 'glsl',
    fp = 'glsl',
    buffer = 'json',
    go = 'protobuf',
    animationset = 'protobuf',
    atlas = 'protobuf',
    camera = 'protobuf',
    collection = 'protobuf',
    collectionfactory = 'protobuf',
    collectionproxy = 'protobuf',
    collisionobject = 'protobuf',
    display_profiles = 'protobuf',
    factory = 'protobuf',
    gamepads = 'protobuf',
    gui = 'protobuf',
    input_binding = 'protobuf',
    label = 'protobuf',
    material = 'protobuf',
    mesh = 'protobuf',
    model = 'protobuf',
    particlefx = 'protobuf',
    render = 'protobuf',
    sound = 'protobuf',
    spinemodel = 'protobuf',
    spinescene = 'protobuf',
    sprite = 'protobuf',
    texture_profiles = 'protobuf',
    tilemap = 'protobuf',
    tilesource = 'protobuf',
    njk = 'html',
    manifest = 'protobuf',
    appmanifest = 'protobuf',
    script_api = 'yaml',
  },
}
