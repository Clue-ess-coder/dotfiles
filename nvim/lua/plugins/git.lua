return {
  {
    "lewis6991/gitsigns.nvim",
    lazy = true,
    event = { "BufReadPre", "BufNewFile" },
    opts = {
      signs = {
        add = { text = "┃" },
        change = { text = "┃" },
        delete = { text = "_" },
        topdelete = { text = "‾" },
        changedelete = { text = "~" },
        untracked = { text = "┆" },
      },
      signs_staged = {
        add = { text = "┃" },
        change = { text = "┃" },
        delete = { text = "_" },
        topdelete = { text = "‾" },
        changedelete = { text = "~" },
        untracked = { text = "┆" },
      },
      signcolumn = true,
      numhl = false,
      linehl = false,
      word_diff = false,
      watch_gitdir = { interval = 1000, follow_files = true },
      attach_to_untracked = true,
      current_line_blame = false,
      current_line_blame_opts = {
        virt_text = true,
        virt_text_pos = "eol",
        delay = 1000,
        ignore_whitespace = false,
      },
      current_line_blame_formatter = "<author>, <author_time:%Y-%m-%d> - <summary>",
      sign_priority = 6,
      status_formatter = nil,
      update_debounce = 200,
      max_file_length = 40000,
      preview_config = {
        border = "rounded",
        style = "minimal",
        relative = "cursor",
        row = 0,
        col = 1,
      },
      on_attach = function(bufnr)
        local map = function(mode, lhs, rhs, desc)
          vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, desc = desc })
        end
        -- Navigation
        map("n", "]h", "<cmd>Gitsigns nav_hunk next<cr>", "Next Hunk")
        map("n", "[h", "<cmd>Gitsigns nav_hunk prev<cr>", "Prev Hunk")
      end,
    },
    keys = {
      {
        "<leader>gg",
        "<cmd>Gitsigns toggle_signs<cr>",
        desc = "Toggle Signs",
      },
      -- Hunk operations
      {
        "<leader>gp",
        "<cmd>Gitsigns preview_hunk<cr>",
        desc = "Preview Hunk",
      },
      {
        "<leader>gP",
        "<cmd>Gitsigns preview_hunk_inline<cr>",
        desc = "Preview Hunk Inline",
      },
      {
        "<leader>gs",
        "<cmd>Gitsigns stage_hunk<cr>",
        desc = "Stage/Unstage Hunk",
      },
      {
        "<leader>gr",
        "<cmd>Gitsigns reset_hunk<cr>",
        desc = "Reset Hunk",
      },
      -- Buffer operations
      {
        "<leader>gR",
        "<cmd>Gitsigns reset_buffer<cmd>",
        desc = "Reset Buffer",
      },
      {
        "<leader>gS",
        "<cmd>Gitsigns stage_buffer<cr>",
        desc = "Stage Buffer",
      },
      -- Blame
      {
        "<leader>gb",
        "<cmd>Gitsigns toggle_current_line_blame<cr>",
        desc = "Blame current line",
      },
      {
        "<leader>gB",
        "<cmd>Gitsigns blame<cr>",
        desc = "Blame Buffer",
      },
      -- Diff
      {
        "<leader>gD",
        function()
          vim.cmd "Gitsigns diffthis HEAD"
        end,
        desc = "Diff HEAD",
      },
    },
  },
  {
    "sindrets/diffview.nvim",
    event = "VeryLazy",
    cmd = { "DiffviewOpen", "DiffviewClose", "DiffviewToggleFiles", "DiffviewFocusFiles" },
  },
  -- Git related plugins
  "tpope/vim-fugitive",
  "tpope/vim-rhubarb",
}
