-- Thank you Tony!
local function enable_transparency()
  vim.cmd "hi Directory guibg=NONE"
  vim.cmd "hi SignColumn guibg=NONE"
  vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
  -- vim.api.nvim_set_hl(0, "NormalFloat", { bg = "none" })
  -- vim.api.nvim_set_hl(0, "LineNr", { bg = "none" })
end

return {
  "ellisonleao/gruvbox.nvim",
  priority = 1000,
  config = function()
    vim.cmd.colorscheme = "gruvbox"
    enable_transparency()
  end,
}
