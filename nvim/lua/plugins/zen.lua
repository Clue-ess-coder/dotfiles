return {
  "folke/zen-mode.nvim",
  opts = {
    window = {
      width = 0.65, -- The width of the "focused" window (65% of screen)
      options = {
        number = false, -- Hide line numbers
        relativenumber = false, -- Hide relative numbers
        cursorline = false, -- Hide cursorline
      },
    },
  },
  keys = {
    { "<leader>zz", "<cmd>ZenMode<cr>", desc = "Toggle Zen Mode" },
  },
}
