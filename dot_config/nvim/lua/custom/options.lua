local o = vim.o

vim.opt.termguicolors = true

-- Use tabs
o.autoindent = true
local function configure_indentation(use_tabs, width)
  if use_tabs then
    vim.opt.expandtab = false
    vim.opt.tabstop = width -- For visual appearance of tab characters
    vim.opt.softtabstop = width -- For max jump distance of manual tabs
    vim.opt.shiftwidth = 0 -- Use tabs indentation
  else
    vim.opt.expandtab = true
    vim.opt.tabstop = width -- For max jump distance of manual tabs
    vim.opt.shiftwidth = width -- For indentation
  end
end
configure_indentation(true, 2)

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
