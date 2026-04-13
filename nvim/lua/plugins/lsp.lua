return {
  "neovim/nvim-lspconfig",
  dependencies = {
    { "mason-org/mason.nvim", opts = {} },
    "mason-org/mason-lspconfig.nvim",
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    { "j-hui/fidget.nvim", opts = {} },
    "saghen/blink.cmp",
    { "folke/lazydev.nvim", opts = {} },
  },
  config = function()
    -- Keymaps + highlights on every LSP attach
    vim.api.nvim_create_autocmd("LspAttach", {
      group = vim.api.nvim_create_augroup("kickstart-lsp-attach", { clear = true }),
      callback = function(event)
        local map = function(keys, func, desc, mode)
          mode = mode or "n"
          vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
        end

        local builtin = require "telescope.builtin"
        map("gr", builtin.lsp_references, { desc = "Goto References" })
        map("gd", builtin.lsp_definitions, { desc = "Goto Definition" })
        map("gO", builtin.lsp_document_symbols, { desc = "Document Symbols" })
        map("K", vim.lsp.buf.hover, { desc = "Hover Documentation" })
        map("gi", vim.lsp.buf.implementation, { desc = "Go to implementation" })
        map("gD", vim.lsp.buf.declaration, { desc = "Go to declaration" })
        map("<leader>ca", vim.lsp.buf.code_action, { desc = "Code Action" })
        map("<leader>rn", vim.lsp.buf.rename, { desc = "Rename" })

        local client = vim.lsp.get_client_by_id(event.data.client_id)
        if client and client:supports_method "textDocument/documentHighlight" then
          local grp = vim.api.nvim_create_augroup("lsp-highlight", { clear = false })
          vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, { buffer = event.buf, group = grp, callback = vim.lsp.buf.document_highlight })
          vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, { buffer = event.buf, group = grp, callback = vim.lsp.buf.clear_references })
        end
      end,
    })

    vim.diagnostic.config {
      virtual_text = true,
      float = { border = "rounded" },
      signs = true,
      underline = true,
      update_in_insert = false,
      severity_sort = true,
    }

    -- ── Server definitions ──────────────────────────────────────────────
    local capabilities = require("blink.cmp").get_lsp_capabilities()

    local servers = {
      -- Lua
      lua_ls = {
        settings = {
          Lua = { completion = { callSnippet = "Replace" } },
        },
      },

      -- TypeScript / JavaScript  (replaces old tsserver)
      ts_ls = {},

      -- Biome: lints + type-checks JS/TS in addition to formatting
      biome = {},

      -- Python
      pyright = {
        settings = {
          python = {
            analysis = {
              typeCheckingMode = "standard",
              autoSearchPaths = true,
              useLibraryCodeForTypes = true,
            },
          },
        },
      },

      -- Rust  (mason name: rust-analyzer)
      rust_analyzer = {
        settings = {
          ["rust-analyzer"] = {
            checkOnSave = { command = "clippy" },
          },
        },
      },

      -- Go
      gopls = {
        settings = {
          gopls = {
            analyses = { unusedparams = true },
            staticcheck = true,
          },
        },
      },

      -- Web / markup
      html = {},
      cssls = {},
      jsonls = {},

      markdown_oxide = {},

      tailwindcss = {
        settings = {
          tailwindCSS = {
            -- lets Tailwind activate in JS/TS files too (for JSX className)
            includeLanguages = {
              javascript = "html",
              javascriptreact = "html",
              typescript = "html",
              typescriptreact = "html",
            },
          },
        },
      },
    }

    -- ── Mason: ensure everything is installed ────────────────────────────
    local ensure_installed = vim.tbl_keys(servers)
    vim.list_extend(ensure_installed, {
      -- formatters Mason installs but lspconfig doesn't know about
      "stylua",
      -- "black",
      -- "isort",
      "goimports",
      "prettierd",
    })

    require("mason-tool-installer").setup { ensure_installed = ensure_installed }

    -- ── mason-lspconfig: wire servers → lspconfig ────────────────────────
    require("mason-lspconfig").setup {
      handlers = {
        function(server_name)
          local server = servers[server_name] or {}
          server.capabilities = vim.tbl_deep_extend("force", {}, capabilities, server.capabilities or {})
          require("lspconfig")[server_name].setup(server)
        end,
      },
    }
  end,
}
