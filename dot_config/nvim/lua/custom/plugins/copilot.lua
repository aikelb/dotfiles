return {
	{
		"zbirenbaum/copilot.lua",
		cmd = "Copilot",
		event = "InsertEnter",
		build = ":Copilot auth",
		opts = {
			-- suggestion = {
			-- 	enabled = true,
			-- 	auto_trigger = false,
			-- 	debounce = 75,
			-- 	keymap = {
			-- 		accept = "<M-l>",
			-- 		accept_word = false,
			-- 		accept_line = false,
			-- 		next = "<M-]>",
			-- 		prev = "<M-[>",
			-- 		dismiss = "<C-]>",
			-- 	},
			-- },
			-- Disabled to cmp works well
			-- suggestion = { enabled = false },
			-- panel = { enabled = false },
		},
		config = true,
	},

	{
		"zbirenbaum/copilot-cmp",
		config = function()
			require("copilot_cmp").setup()
		end,
	},

	{ "AndreM222/copilot-lualine" },
}
