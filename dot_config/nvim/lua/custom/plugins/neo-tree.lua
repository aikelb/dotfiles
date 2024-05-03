return {
	"nvim-neo-tree/neo-tree.nvim",
	branch = "v3.x",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"nvim-tree/nvim-web-devicons",
		"MunifTanjim/nui.nvim",
	},
	config = function()
		require("neo-tree").setup({
			close_if_last_window = true,
			window = {
				width = 30,
			},
			buffers = {
				follow_current_file = { enabled = true },
			},
			filesystem = {
				follow_current_file = { enabled = true },
				filtered_items = {
					hide_dotfiles = true,
					hide_gitignored = true,
					hide_by_name = {
						"node_modules",
						".defold",
						".vscode",
					},
					never_show = {
						".DS_Store",
						"thumbs.db",
					},
				},
			},
		})
	end,
}
