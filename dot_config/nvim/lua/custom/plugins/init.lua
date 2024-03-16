-- You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
--
-- See the kickstart.nvim README for more information
return {
	{
		"nvim-pack/nvim-spectre",
		event = "BufRead",
		config = function()
			require("spectre").setup()
		end,
	},

	{
		"nvim-neo-tree/neo-tree.nvim",
		branch = "*",
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
						hide_dotfiles = false,
						hide_gitignored = false,
						hide_by_name = {
							"node_modules",
						},
						never_show = {
							".DS_Store",
							"thumbs.db",
						},
					},
				},
			})
		end,
	},

	-- tabs
	{ "akinsho/bufferline.nvim", version = "*", dependencies = "nvim-tree/nvim-web-devicons", opts = {} },

	-- status line
	{
		"sontungexpt/sttusline",
		branch = "table_version",
		dependencies = {
			"nvim-tree/nvim-web-devicons",
		},
		event = "BufEnter",
		opts = {
			-- on_attach = function(create_update_group) end

			-- the colors of statusline will be set follow the colors of the active buffer
			-- statusline_color = "#fdff00",
			statusline_color = "StatusLine",
			disabled = {
				filetypes = {
					-- "NvimTree",
					-- "lazy",
				},
				buftypes = {
					"terminal",
				},
			},
			components = {
				"mode",
				"os-uname",
				"filename",
				"git-branch",
				"git-diff",
				"%=",
				"diagnostics",
				"lsps-formatters",
				"indent",
				"encoding",
				"pos-cursor",
				"pos-cursor-progress",
			},
		},
		config = function(_, opts)
			require("sttusline").setup(opts)
		end,
	},
}
