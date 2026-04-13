-- local function enable_transparency()
--   vim.api.nvim_set_hl(0, "Normal", { bg = "none" })
--   vim.api.nvim_set_hl(0, "SignColumn", { bg = "none" })
--   vim.api.nvim_set_hl(0, "Directory", { bg = "none" })
-- end

return {
  "ellisonleao/gruvbox.nvim",
  priority = 1000,
  config = function()
    require("gruvbox").setup {
      contrast = "soft",
      transparent_mode = true,
    }

    vim.cmd.colorscheme "gruvbox"

    -- enable_transparency()
  end,
}
