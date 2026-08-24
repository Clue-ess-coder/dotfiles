vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.keymap.set("n", "<leader>w", "<cmd>w<CR>", { desc = "Write file" })
vim.keymap.set("n", "<leader>wq", "<cmd>wqa<CR>", { desc = "Write and quit all" })
vim.keymap.set("n", "<leader>q", "<cmd>q<CR>", { desc = "Press Shift+q to quit" })
vim.keymap.set("n", "<leader>Q", "<cmd>q!<cr>", { desc = "Force quit window" })
vim.keymap.set("n", "<leader>qq", "<cmd>qa<cr>", { desc = "Quit all" })

vim.keymap.set("n", "-", "<cmd>Ex<CR>", { desc = "Open Netrw Explorer" })
vim.keymap.set("n", "<leader>we", "<cmd>w | Ex<cr>", { desc = "Save file and open explorer" })
vim.keymap.set("n", "<leader>cd", "<cmd>Lex<cr>", { desc = "List buffer diagnostic" })

vim.keymap.set("n", "vag", "ggVG", { desc = "Select All" })
vim.keymap.set({ "n", "i" }, "<A-j>", "<C-c>")
vim.keymap.set("n", "<A-j>", "<cmd>nohlsearch<CR>")

-- vim.keymap.set("n", "<leader>rl", "<cmd>source ~/.config/nvim/init.lua<cr>")

vim.keymap.set("n", "<C-h>", "<C-w><C-h>")
vim.keymap.set("n", "<C-l>", "<C-w><C-l>")
vim.keymap.set("n", "<C-j>", "<C-w><C-j>")
vim.keymap.set("n", "<C-k>", "<C-w><C-k>")

-- Resize with arrows when using multiple windows
vim.keymap.set("n", "<C-Up>", "<cmd>resize +2<cr>")
vim.keymap.set("n", "<c-down>", "<cmd>resize -2<cr>")
vim.keymap.set("n", "<c-right>", "<cmd>vertical resize -2<cr>")
vim.keymap.set("n", "<c-left>", "<cmd>vertical resize +2<cr>")

-- Better visual mode indenting (stays in visual mode)
vim.keymap.set("v", "<", "<gv")
vim.keymap.set("v", ">", ">gv")

-- Fix the annoying line joining thingy
vim.keymap.set("n", "J", "<Nop>", { noremap = true, desc = "Disable default J" })
vim.keymap.set("n", "<Leader>j", "mzJ`z", { noremap = true, desc = "Join line (default behavior)" })

-- Additions from Prime
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")
vim.keymap.set("n", "*", "*zzzv", { desc = "Search Word (centered)" })
vim.keymap.set("n", "#", "#zzzv", { desc = "Search Word Back (centered)" })
vim.keymap.set("n", "=ap", "ma=ap'a")

-- Move Commands
vim.keymap.set("v", "J", ":m '>+1<cr>gv=gv", { silent = true })
vim.keymap.set("v", "K", ":m '<-2<cr>gv=gv", { silent = true })

-- Line Commands
-- vim.keymap.set({ "n", "v" }, "gl", "$", { desc = "go to the end of the line" })
-- vim.keymap.set({ "n", "v" }, "gh", "^", { desc = "Go to the beginning line" })

-- Smart Deletions
vim.keymap.set("n", "dd", '"_dd', { desc = "Delete line (no yank)" })
vim.keymap.set("n", "D", '"_D', { desc = "Delete line from cursor position (no yank)" })
vim.keymap.set("n", "x", '"_x', { desc = "Delete character (no yank)" })
vim.keymap.set("v", "p", '"_dP', { desc = "Paste (no yank)" })

-- Split Management
vim.keymap.set("n", "<leader>s", "<cmd>sp<cr>", { desc = "New horizontal split" })
vim.keymap.set("n", "<leader>v", "<cmd>vsp<cr>", { desc = "New vertical split" })

-- Buffer Management
vim.keymap.set("n", "<leader>bd", "<cmd>bp|sp|bn|bd<cr>", { desc = "Close buffer, keep window" })
vim.keymap.set("n", "<leader>bn", "<cmd>enew<CR>", { desc = "New empty buffer" })

-- Tab Management
vim.keymap.set("n", "[t", "<cmd>tabprevious<CR>", { desc = "Previous tab" })
vim.keymap.set("n", "]t", "<cmd>tabnext<CR>", { desc = "Next tab" })
vim.keymap.set("n", "<leader>tn", "<cmd>tabnew<CR>", { desc = "New tab" })
vim.keymap.set("n", "<leader>tc", "<cmd>tabclose<CR>", { desc = "Close tab" })

-- Terminal Shortcuts
vim.keymap.set("n", "<leader>T", "<cmd>terminal<cr>i", { desc = "Open terminal" })
vim.keymap.set("n", "<leader>ts", "<cmd>split | terminal<cr>i", { desc = "Horizontal terminal split" })
vim.keymap.set("n", "<leader>tv", "<cmd>vsplit | terminal<cr>i", { desc = "Vertical terminal split" })

-- Extras
vim.keymap.set("n", "<leader>E", vim.diagnostic.setloclist, { desc = "List buffer diagnostic" })
vim.keymap.set("n", "<leader>fc", "<cmd>G<cr>", { desc = "Open Git fugitive" })
vim.keymap.set("n", "<leader>C", ':G commit -m "', { desc = "Git commit" })
