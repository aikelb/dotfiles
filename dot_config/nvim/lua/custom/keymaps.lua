local map = vim.keymap.set

-- Keymap for toggling the tree - Neo-Tree
map("n", "<C-n>", ":Neotree toggle<CR>", { desc = "Toggle neotree" })

-- Tabs
map("n", "<Tab>", ":BufferLineCycleNext<CR>", { desc = "Cycle Next Tab" })
map("n", "<S-Tab>", ":BufferLineCyclePrev<CR>", { desc = "Cycle Previous Tab" })
map("n", "<A-w>", ":bd<CR>", { desc = "Close current buffer" })
map("n", "<A-n>", ":enew<CR>", { desc = "New buffer" })

-- TIP: Disable arrow keys in normal mode
-- vim.keymap.set('n', '<left>', '<cmd>echo "Use h to move!!"<CR>')
-- vim.keymap.set('n', '<right>', '<cmd>echo "Use l to move!!"<CR>')
-- vim.keymap.set('n', '<up>', '<cmd>echo "Use k to move!!"<CR>')
-- vim.keymap.set('n', '<down>', '<cmd>echo "Use j to move!!"<CR>')
