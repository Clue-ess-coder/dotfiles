return {
  "saghen/blink.cmp",
  -- optional: provides snippets for the snippet source
  dependencies = { "saghen/blink.lib", "rafamadriz/friendly-snippets" },

  -- use a release tag to download pre-built binaries
  version = "1.*",

  ---@module 'blink.cmp'
  ---@type blink.cmp.Config
  opts = {
    -- 'default' (recommended) for mappings similar to built-in completions (C-y to accept)
    -- 'super-tab' for mappings similar to vscode (tab to accept)
    -- 'enter' for enter to accept
    -- 'none' for no mappings
    keymap = { preset = "super-tab" },

    appearance = {
      nerd_font_variant = "mono",
    },

    sources = {
      default = { "lazydev", "lsp", "path", "buffer", "snippets" },
      providers = {
        lazydev = {
          name = "LazyDev",
          module = "lazydev.integrations.blink",
          score_offset = 100,
        },
        cmdline = {
          min_keyword_length = 2,
        },
      },
    },

    completion = {
      menu = {
        border = "rounded",
        scrolloff = 1,
        scrollbar = false,
        auto_show = true,
        draw = {
          padding = 1,
          gap = 1,
          columns = {
            { "kind_icon" },
            { "label", "label_description", gap = 1 },
            { "kind" },
            { "source_name" },
          },
        },
      },

      documentation = {
        window = {
          border = "rounded",
          scrollbar = false,
          winhighlight = "Normal:BlinkCmpDoc,FloatBorder:BlinkCmpDocBorder,EndOfBuffer:BlinkCmpDoc",
        },
        auto_show = true,
        auto_show_delay_ms = 500,
      },
    },

    fuzzy = { implementation = "prefer_rust_with_warning" },
  },
  opts_extend = { "sources.default" },
}
