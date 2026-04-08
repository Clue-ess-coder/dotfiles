vim.o.shell = "pwsh.exe"
vim.o.number = true
vim.o.relativenumber = false

vim.o.mouse = "a"
vim.o.showmode = false

vim.o.tabstop = 4
vim.o.shiftwidth = 4
vim.o.autoindent = true
vim.o.expandtab = true

vim.o.breakindent = true
vim.o.swapfile = false
vim.o.backup = false
vim.o.undodir = os.getenv "HOME" .. "/.vim/undodir"
vim.o.undofile = true

vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.smartindent = true

vim.o.signcolumn = "yes"
vim.o.updatetime = 250
vim.o.timeoutlen = 300

vim.o.hidden = true
vim.o.autoread = true
vim.o.autowrite = false
vim.o.selection = "inclusive"

vim.o.colorcolumn = "100"

vim.o.splitright = true
vim.o.splitbelow = true

vim.o.list = true
vim.opt.listchars = { tab = "  ", trail = "·", nbsp = "␣" }

vim.o.inccommand = "split"
vim.o.cursorline = true
vim.o.scrolloff = 15
vim.o.confirm = false

vim.o.termguicolors = true
vim.o.background = "dark"

vim.o.backspace = "indent,eol,start"
vim.o.incsearch = true

vim.schedule(function()
  vim.o.clipboard = "unnamedplus"
end)

-- source: https://github.com/adibhanna/nvim/blob/main/lua/core/options.lua
-- ============================================================================
-- Filetype Detection
-- ============================================================================
-- vim.filetype.add({
--   extension = {
--     env = "dotenv", -- Treat .env extension as dotenv filetype
--   },
--   filename = {
--     [".env"] = "dotenv", -- Treat .env file as dotenv filetype
--     ["env"] = "dotenv", -- Treat env file as dotenv filetype
--   },
--   pattern = {
--     ["[jt]sconfig.*.json"] = "jsonc", -- Treat tsconfig/jsconfig files as JSONC (allows comments)
--     ["%.env%.[%w_.-]+"] = "dotenv", -- Treat .env.* files as dotenv filetype
--   },
-- })
