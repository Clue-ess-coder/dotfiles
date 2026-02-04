local term_buf = nil
local term_win = nil

local function toggle_stterminal()
  if term_win and vim.api.nvim_win_is_valid(term_win) then
    vim.api.nvim_win_hide(term_win)
    term_win = nil
    return
  end

  if term_buf and vim.api.nvim_buf_is_valid(term_buf) then
    vim.cmd.split()
    vim.cmd.wincmd "J"
    vim.api.nvim_win_set_height(0, 10)
    vim.api.nvim_win_set_buf(0, term_buf)
    term_win = vim.api.nvim_get_current_win()
  else
    vim.cmd.split()
    vim.cmd.wincmd "J"
    vim.api.nvim_win_set_height(0, 10)
    vim.cmd.term()
    term_buf = vim.api.nvim_get_current_buf()
    term_win = vim.api.nvim_get_current_win()

    -- Set local options for the terminal buffer
    vim.bo[term_buf].buflisted = false
  end

  -- IMPORTANT: Only enter insert mode if you want to start typing immediately.
  -- You can comment this out if you prefer to start in Normal mode.
  vim.cmd "startinsert"
end

return {
  -- This dummy entry allows us to use the 'init' function to set up keymaps properly
  dir = vim.fn.stdpath "config",
  name = "local_terminal",
  config = function()
    -- Toggle Terminal (Normal and Terminal modes)term
    vim.keymap.set({ "n", "t" }, "<space>tt", toggle_stterminal, { desc = "Toggle terminal" })

    -- EASIER ESCAPE: This is what you really need for Vi-mode workflow
    -- Press Esc twice to enter Normal mode inside the terminal
    vim.keymap.set("t", "<Esc><Esc>", [[<C-\><C-n>]], { desc = "Exit terminal mode" })

    -- Better navigation to leave the terminal window without closing it
    vim.keymap.set("t", "<C-h>", [[<C-\><C-n><C-w>h]])
    vim.keymap.set("t", "<C-j>", [[<C-\><C-n><C-w>j]])
    vim.keymap.set("t", "<C-k>", [[<C-\><C-n><C-w>k]])
    vim.keymap.set("t", "<C-l>", [[<C-\><C-n><C-w>l]])
  end,
}
