local map = vim.keymap.set

-- Keymap for toggling the tree - Neo-Tree
map("n", "<C-n>", ":Neotree toggle<CR>", { desc = "Toggle neotree" })

-- Tabs
map("n", "<Tab>", ":BufferLineCycleNext<CR>", { desc = "Cycle Next Tab" })
map("n", "<S-Tab>", ":BufferLineCyclePrev<CR>", { desc = "Cycle Previous Tab" })
map("n", "<A-w>", ":bp<bar>sp<bar>bn<bar>bd<CR>", { desc = "Close current buffer" })
map("n", "<A-n>", ":enew<CR>", { desc = "New buffer" })

-- Telescope workspace
map("n", "<leader>wd", ":Telescope neovim-project discover<CR>", { desc = "[W]orkspace [D]iscover"})
map("n", "<leader>wh", ":Telescope neovim-project history<CR>", { desc = "[W]orkspace [H]istory"})
map("n", "<leader>wl", ":NeovimProjectLoadRecent<CR>", { desc = "[W]orkspace [L]oad Recent"})

-- Telescope file browser
map("n", "<leader>fb", ":Telescope file_browser<CR>", { desc = "[F]ile [B]rowser" })
map("n", "<leader>fp", ":Telescope file_browser path=%:p:h select_buffer=true<CR>", { desc = "[File] Browser Buffer [P]ath" })

-- Trailing spaces
map("n", "<leader>ft", ":%s/\\s\\+$//e<CR>", {desc = "[F]ormat [T]railing spaces"})

-- Mini Surround mappings
map("n", "gsa", ":lua require('mini.surround').add()<CR>", { desc = "Add Surround" })
map("n", "gsd", ":lua require('mini.surround').delete()<CR>", { desc = "Delete Surround" })
map("n", "gsf", ":lua require('mini.surround').find()<CR>", { desc = "Find Surround" })
map("n", "gsF", ":lua require('mini.surround').find_left()<CR>", { desc = "Find Surround Left" })
map("n", "gsh", ":lua require('mini.surround').highlight()<CR>", { desc = "Highlight Surround" })
map("n", "gsr", ":lua require('mini.surround').replace()<CR>", { desc = "Replace Surround" })
map("n", "gsn", ":lua require('mini.surround').update_n_lines()<CR>", { desc = "Update Surround N Lines" })

-- Defold
map("n", "<leader>mr", ":wa<CR>:!make run<CR>", { desc = "Make run" })
map("n", "<leader>mt", ":wa<CR>:!make test<CR>", { desc = "Make test" })

-- TIP: Disable arrow keys in normal mode
-- vim.keymap.set('n', '<left>', '<cmd>echo "Use h to move!!"<CR>')
-- vim.keymap.set('n', '<right>', '<cmd>echo "Use l to move!!"<CR>')
-- vim.keymap.set('n', '<up>', '<cmd>echo "Use k to move!!"<CR>')
-- vim.keymap.set('n', '<down>', '<cmd>echo "Use j to move!!"<CR>')
