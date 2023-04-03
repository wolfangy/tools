vim.g.mapleader = " "

local keymap = vim.keymap

--General keymaps
keymap.set ("n", "<leader>pv", vim.cmd.Ex)

-- Escape the input mode
keymap.set ("i", "jk", "<ESC>")
keymap.set ("i", "kj", "<ESC>")


keymap.set ("v", "J", ":m '>+1<CR>gv=gv")
keymap.set ("v", "K", ":m '<-2<CR>gv=gv")

-- Clear the search highlight
keymap.set ("n", "<leader>nh", ":nohl<CR>")

-- Delete the character without put into register
keymap.set ("n", "x", '"_x')

--keymap.set ("n", "<leader>+", "<C-a>")
keymap.set ("n", "<leader>-", "<C-x>")

keymap.set ("n", "<leader>sv", "<C-w>v")     -- splict window vertically
keymap.set ("n", "<leader>sh", "<C-w>s")     -- split window horizontally
keymap.set ("n", "<leader>se", "<C-w>=")     -- make split window equal width
keymap.set ("n", "<leader>sx", ":close<CR>") -- close current split window

keymap.set ("n", "<leader>to", ":tabnew<CR>")   -- open a new tab
keymap.set ("n", "<leader>tx", ":tabclose<CR>") -- close a tab
keymap.set ("n", "<leader>tn", ":tabn<CR>")     -- go to next tab
keymap.set ("n", "<leader>tp", ":tabp<CR>")     -- go to previous tab

-- plugin keymaps

-- vim-maximizer
keymap.set ("n", "<leader>sm", ":MaximizerToggle<CR>")

-- nvim-tree
keymap.set ("n", "<leader>e", ":NvimTreeToggle<CR>")


-- telescope
keymap.set ("n", "<leader>ff", "<cmd>Telescope find_files<cr>")
keymap.set ("n", "<leader>fs", "<cmd>Telescope live_grep<cr>")
keymap.set ("n", "<leader>fc", "<cmd>Telescope grep_string<cr>")
keymap.set ("n", "<leader>fb", "<cmd>Telescope buffers<cr>")
keymap.set ("n", "<leader>fh", "<cmd>Telescope help_tags<cr>")
