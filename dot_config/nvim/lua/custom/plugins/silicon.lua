return {
  'michaelrommel/nvim-silicon',
  lazy = true,
  cmd = 'Silicon',
	main = "nvim-silicon",
  config = function()
    require('nvim-silicon').setup {
      font = 'FiraCode Nerd Font=34',
      theme = 'Dracula',
      background = '#94e2d5',
      to_clipboard = true,
      gobble = true,
    }
  end,
}
