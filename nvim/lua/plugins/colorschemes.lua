return {
  {
    "ellisonleao/gruvbox.nvim",
    priority = 1000,
    config = function()
      require("gruvbox").setup {
        contrast = "soft",
        transparent_mode = true,
      }
    end,
  },
  {
    "AlexvZyl/nordic.nvim",
    lazy = false,
    priority = 1000,
    config = function()
      require("nordic").setup {
        bold_keywords = false,
        italic_comments = false,
        transparent = { bg = true, float = false },
        bright_border = false,
        reduced_blue = true,
        swap_backgrounds = false,
        cursorline = {
          bold = false,
          bold_number = true,
          theme = "dark",
          blend = 0.85,
        },
        noice = { style = "flat" },
        telescope = { style = "flat" },
        leap = { dim_backdrop = false },
        ts_context = { dark_background = true },
      }
    end,
  },
  {
    "adibhanna/forest-night.nvim",
    priority = 1000,
  },
}
