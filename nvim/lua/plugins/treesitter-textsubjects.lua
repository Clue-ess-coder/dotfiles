return {
  "nvim-treesitter/nvim-treesitter-textsubjects",
  dependencies = { "nvim-treesitter/nvim-treesitter" },
  config = function()
    require("nvim-treesitter.configs").setup {
      textsubjects = {
        enable = true,
        prev_selection = ",", -- (Optional) repeat selection with ','
        keymaps = {
          ['."]'] = "textsubjects-smart", -- Select outward
          [";"] = "textsubjects-container-outer", -- Select container
          ["i;"] = "textsubjects-container-inner", -- Select container inner
        },
      },
    }
  end,
}
