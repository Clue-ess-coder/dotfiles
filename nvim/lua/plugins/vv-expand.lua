return {
  "beixiyo/vv-expand.nvim",
  event = { "BufReadPost", "BufNewFile" },
  ---@type VVExpandConfig
  opts = {
    pairs = {
      same = { '"', "'", "`", "*", "_", "-" }, -- Same-character pairs
      nested = { -- Nested bracket pairs
        { "(", ")" },
        { "[", "]" },
        { "{", "}" },
        { "<", ">" },
      },
    },
    layers = { "word", "pair", "lsp", "treesitter", "line" }, -- Expansion strategy priority
    keymaps = {
      init = "<CR>", -- Start in normal mode
      expand = "<CR>", -- Expand in visual mode
      shrink = "<BS>", -- Shrink in visual mode
    },
    subword_delimiters = "-=+/:;|,.?\\!@#$%^&*~", -- Segment delimiters; nil disables subword expansion
    filetype_exclude = {
      "qf",
      "help",
      "dashboard",
      "vv-explorer",
      "vv-task-panel",
      "vv-task-panel-tasks",
      "TelescopePrompt",
    },
    lsp_timeout = 400, -- LSP selectionRange timeout (ms)
  },
}
