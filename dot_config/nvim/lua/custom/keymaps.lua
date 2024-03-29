local map = vim.keymap.set

-- Keymap for toggling the tree - Neo-Tree
map("n", "<C-n>", ":Neotree toggle<CR>", { desc = "Toggle neotree" })

-- Tabs
map("n", "<Tab>", ":BufferLineCycleNext<CR>", { desc = "Cycle Next Tab" })
map("n", "<S-Tab>", ":BufferLineCyclePrev<CR>", { desc = "Cycle Previous Tab" })

-- Format files
map("n", "<leader>fm", function()
	require("conform").format()
end, { desc = "File Format with conform" })

-- TIP: Disable arrow keys in normal mode
-- vim.keymap.set('n', '<left>', '<cmd>echo "Use h to move!!"<CR>')
-- vim.keymap.set('n', '<right>', '<cmd>echo "Use l to move!!"<CR>')
-- vim.keymap.set('n', '<up>', '<cmd>echo "Use k to move!!"<CR>')
-- vim.keymap.set('n', '<down>', '<cmd>echo "Use j to move!!"<CR>')
