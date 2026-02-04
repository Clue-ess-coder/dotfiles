return {
  "stevearc/conform.nvim",
  event = { "BufWritePre" },
  cmd = { "ConformInfo" },
  keys = {
    {
      "<leader>f",
      function()
        require("conform").format { async = true, lsp_format = "fallback" }
      end,
      mode = "",
      desc = "[F]ormat buffer",
    },
  },
  opts = {
    notify_on_error = false,
    format_on_save = function(bufnr)
      -- Add languages here that you want to skip formatting for
      local ignore_filetypes = { "c", "cpp" }
      if vim.tbl_contains(ignore_filetypes, vim.bo[bufnr].filetype) then
        return
      end

      return {
        timeout_ms = 500,
        lsp_format = "fallback",
      }
    end,
    formatters_by_ft = {
      lua = { "stylua" },
      -- Example: run isort then black on python files
      -- python = { "isort", "black" },

      -- Use "_" as a fallback for all filetypes that don't have a formatter
      -- ["_"] = { "trim_whitespace" },
    },
  },
}
