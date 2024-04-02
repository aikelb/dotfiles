return {
	-- url: https://github.com/nvimdev/dashboard-nvim?tab=readme-ov-file"
--[[ 	"nvimdev/dashboard-nvim",
	event = "VimEnter",
	config = function()
		require("dashboard").setup({
			theme = "hyper",
			config = {
				week_header = {
					enable = true,
				},
				shortcut = {
					{ desc = "󰊳 Update", group = "@property", action = "Lazy update", key = "u" },
					{
						icon = " ",
						icon_hl = "@variable",
						desc = "Files",
						group = "Label",
						action = "Telescope find_files",
						key = "f",
					},
					{
						desc = " Apps",
						group = "DiagnosticHint",
						action = "Telescope app",
						key = "a",
					},
					{
						desc = " dotfiles",
						group = "Number",
						action = "Telescope dotfiles",
						key = "d",
					},
				},
			},
		})
	end,
	dependencies = { { "nvim-tree/nvim-web-devicons" } }, ]]
	-- url: https://github.com/goolord/alpha-nvim

	"goolord/alpha-nvim",
	dependencies = {
		"nvim-tree/nvim-web-devicons",
		"nvim-lua/plenary.nvim",
	},
	config = function()
		local alpha = require("alpha")
		local theta = require("alpha.themes.theta")
		local dashboard = require("alpha.themes.dashboard")

		local buttons = {
			type = "group",
			val = {
				{ type = "text",    val = "Quick links", opts = { hl = "SpecialComment", position = "center" } },
				{ type = "padding", val = 1 },
				dashboard.button("e", "  New file", "<cmd>ene<CR>"),
				dashboard.button("SPC s f", "󰈞  Find file"),
				dashboard.button("SPC s g", "󰊄  Live grep"),
				dashboard.button("c", "  Configuration", "<cmd>cd ~/.config/nvim/ <CR>"),
				dashboard.button("u", "  Update plugins", "<cmd>Lazy sync<CR>"),
				dashboard.button("q", "󰅚  Quit", "<cmd>qa<CR>"),
			},
			position = "center",
		}

		theta.config.layout[6] = buttons
		alpha.setup(theta.config)
	end,
}
