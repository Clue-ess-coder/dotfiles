vim.o.shell = "pwsh.exe"
vim.o.number = true
vim.o.relativenumber = true

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

-- AUTOCOMMANDS
vim.api.nvim_create_autocmd("TextYankPost", {
  desc = "Highlight when yanking (copying) text",
  group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
  callback = function()
    vim.hl.on_yank()
  end,
})

vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
  group = vim.api.nvim_create_augroup("clear_cmdline", { clear = true }),
  callback = function()
    vim.defer_fn(function()
      vim.cmd 'echo ""'
    end, 6000)
  end,
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = "markdown",
  group = vim.api.nvim_create_augroup("markdown_sanity", { clear = true }),
  callback = function()
    vim.opt_local.wrap = true
    vim.opt_local.linebreak = true
    vim.opt_local.breakindent = true

    vim.keymap.set("n", "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, buffer = true })
    vim.keymap.set("n", "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, buffer = true })

    vim.opt_local.spell = true
  end,
})

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
