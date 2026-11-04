-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- LazyVim equivalents of the old kickstart maps:
--   lazygit        <leader>gg     find/replace (spectre)  <leader>sr
--   projects       <leader>fp     sessions                <leader>qs / <leader>ql
--   explorer       <leader>e      flash                   s / S

local map = vim.keymap.set

-- Buffers
map("n", "<Tab>", "<cmd>bnext<cr>", { desc = "Next Buffer" })
map("n", "<S-Tab>", "<cmd>bprevious<cr>", { desc = "Prev Buffer" })
map("n", "<A-w>", function() Snacks.bufdelete() end, { desc = "Close Buffer" })
map("n", "<A-n>", "<cmd>enew<cr>", { desc = "New Buffer" })

-- Explorer (kickstart muscle memory; <leader>e also works)
map("n", "<C-n>", "<cmd>Neotree toggle<cr>", { desc = "Toggle Neo-tree" })

-- Trim trailing whitespace
map("n", "<leader>cw", [[<cmd>%s/\s\+$//e<cr>]], { desc = "Trim Trailing Whitespace" })

-- Make targets
map("n", "<leader>mr", "<cmd>wa<cr><cmd>!make run<cr>", { desc = "Make Run" })
map("n", "<leader>mt", "<cmd>wa<cr><cmd>!make test<cr>", { desc = "Make Test" })
