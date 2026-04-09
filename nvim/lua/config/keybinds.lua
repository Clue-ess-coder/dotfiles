vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.keymap.set("n", "<leader>w", "<cmd>w<CR>", { silent = true, desc = "Write file" })
vim.keymap.set("n", "<leader>wq", "<cmd>wqa<CR>", { silent = true, desc = "Write and quit all" })
vim.keymap.set("n", "Q", "<cmd>q<CR>", { silent = true, desc = "Press Shift+q to quit" })

vim.keymap.set("n", "<S-e>", vim.cmd.Ex, { desc = "Shift+e to open Netrw" })
vim.keymap.set("n", "<leader>we", function()
  vim.cmd "w | Ex"
end)

vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist)

vim.keymap.set("n", "<C-a>", "ggVG", { desc = "Select All" })
vim.keymap.set({ "n", "i" }, "<A-j>", "<C-c>")
vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")

vim.keymap.set("n", "<leader>rl", "<cmd>source ~/.config/nvim/init.lua<cr>")
vim.keymap.set("n", "<leader><leader>", function()
  vim.cmd "so"
end)

vim.keymap.set("n", "<C-h>", "<C-w><C-h>")
vim.keymap.set("n", "<C-l>", "<C-w><C-l>")
vim.keymap.set("n", "<C-j>", "<C-w><C-j>")
vim.keymap.set("n", "<C-k>", "<C-w><C-k>")

-- Resize with arrows when using multiple windows
vim.keymap.set("n", "<C-Up>", ":resize -2<CR>")
vim.keymap.set("n", "<c-down>", ":resize +2<cr>")
vim.keymap.set("n", "<c-right>", ":vertical resize -2<cr>")
vim.keymap.set("n", "<c-left>", ":vertical resize +2<cr>")

-- Better visual mode indenting (stays in visual mode)
vim.keymap.set("v", "<", "<gv")
vim.keymap.set("v", ">", ">gv")

-- Additions from Prime
vim.keymap.set("n", "J", "mzJ`z")
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")
vim.keymap.set("n", "*", "*zzzv", { desc = "Search Word (centered)" })
vim.keymap.set("n", "#", "#zzzv", { desc = "Search Word Back (centered)" })
vim.keymap.set("n", "=ap", "ma=ap'a")

vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- New Additions till I get to them, someday. LMAO
vim.keymap.set({ "n", "v" }, "L", "$", { desc = "go to the end of the line" })
vim.keymap.set({ "n", "v" }, "H", "^", { desc = "Go to the beginning line" })

vim.keymap.set("n", "x", '"_x')
vim.keymap.set("v", "p", '"_dP', { desc = "Paste (no yank)" })
vim.keymap.set({ "n", "v" }, "<leader>y", [["+y]])
vim.keymap.set({ "n", "v" }, "<leader>d", '"_d', { desc = "Delete (no yank)" })
-- vim.keymap.set("x", "<leader>p", [["_dP]])
-- vim.keymap.set("n", "<leader>Y", [["+Y]])

-- Buffer Management
vim.keymap.set("n", "<leader>bd", ":bdelete!<CR>", { desc = "Close current buffer" })
vim.keymap.set("n", "<leader>bn", ":enew<CR>", { desc = "New empty buffer" })

-- Tab Management
vim.keymap.set("n", "[t", ":tabprevious<CR>", { desc = "Previous tab" })
vim.keymap.set("n", "]t", ":tabnext<CR>", { desc = "Next tab" })
vim.keymap.set("n", "<leader>tn", ":tabnew<CR>", { desc = "New tab" })
vim.keymap.set("n", "<leader>tc", ":tabclose<CR>", { desc = "Close tab" })

-- Terminal Shortcuts
-- vim.keymap.set("n", "<leader>tt", ":terminal<CR>", { desc = "Open terminal" })
vim.keymap.set("n", "<leader>ts", ":split | terminal<CR>", { desc = "Horizontal terminal split" })
vim.keymap.set("n", "<leader>tv", ":vsplit | terminal<CR>", { desc = "Vertical terminal split" })
