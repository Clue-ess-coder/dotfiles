return {
  "MeanderingProgrammer/render-markdown.nvim",
  ft = { "markdown" },
  dependencies = { "nvim-treesitter/nvim-treesitter", "nvim-tree/nvim-web-devicons" }, -- if you prefer nvim-web-devicons
  ---@module 'render-markdown'
  ---@type render.md.UserConfig
  opts = {
    heading = {
      enabled = true,
      sign = false,
      icons = { "# ", "## ", "### ", "#### ", "##### ", "###### " },
    },
    code = {
      enabled = true,
      sign = false,
      style = "full",
      left_pad = 1,
      right_pad = 1,
      border = "thin",
      language_pad = 1,
    },
    bullet = {
      enabled = true,
      icons = { "●", "○", "◆", "◇" },
    },
    checkbox = {
      enabled = true,
      unchecked = { icon = "☐ " },
      checked = { icon = "☑ " },
    },
    quote = { enabled = true, icon = "▎" },
    pipe_table = { enabled = true, style = "full" },
    callout = {
      note = { raw = "[!NOTE]", rendered = " Note", highlight = "RenderMarkdownInfo" },
      tip = { raw = "[!TIP]", rendered = " Tip", highlight = "RenderMarkdownSuccess" },
      important = { raw = "[!IMPORTANT]", rendered = " Important", highlight = "RenderMarkdownHint" },
      warning = { raw = "[!WARNING]", rendered = " Warning", highlight = "RenderMarkdownWarn" },
      caution = { raw = "[!CAUTION]", rendered = " Caution", highlight = "RenderMarkdownError" },
    },
  },
  keys = {
    { "<leader>mr", "<cmd>RenderMarkdown toggle<cr>", desc = "Render Markdown Toggle", ft = "markdown" },
  },
}
