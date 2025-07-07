return {
  'michaelrommel/nvim-silicon',
  lazy = true,
  cmd = 'Silicon',
  config = function()
    require('silicon').setup {
      font = 'FiraCode Nerd Font=34',
      theme = 'Dracula',
      background = '#94e2d5',
      to_clipboard = true,
      gobble = true,
    }
  end,
}
