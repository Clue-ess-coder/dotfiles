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

        map("gd", builtin.lsp_definitions, "Goto Definition")
        map("gD", vim.lsp.buf.declaration, "Goto Declaration")
        map("gr", builtin.lsp_references, "Goto References")
        map("gI", builtin.lsp_implementations, "Goto Implementations")
        map("gy", builtin.lsp_type_definitions, "Type Definition")

        map("<leader>ls", builtin.lsp_document_symbols, "Document Symbols")
        map("<leader>ll", builtin.lsp_workspace_symbols, "Workspace Symbols")
        map("<leader>L", builtin.lsp_dynamic_workspace_symbols, "Dynamic Workspace Symbols")

        map("<leader>ca", vim.lsp.buf.code_action, "Code actions")
        map("<leader>cr", vim.lsp.buf.rename, "Code: Rename")

        map("<C-k>", vim.lsp.buf.signature_help, "Signature Help")
        map("K", function()
          vim.lsp.buf.hover { border = "rounded", max_height = 25, max_width = 120 }
        end, "Hover Information")

        map("gl", function()
          vim.diagnostic.open_float { border = "rounded", focusable = false }
        end, "Show diagnostic details")
        map("[d", function()
          vim.diagnostic.jump { count = -1 }
        end, "Prev Diagnostic")
        map("]d", function()
          vim.diagnostic.jump { count = 1 }
        end, "Next Diagnostic")

        local client = vim.lsp.get_client_by_id(event.data.client_id)
        if client and client:supports_method "textDocument/documentHighlight" then
          local grp = vim.api.nvim_create_augroup("lsp-highlight", { clear = false })
          vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, { buffer = event.buf, group = grp, callback = vim.lsp.buf.document_highlight })
          vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, { buffer = event.buf, group = grp, callback = vim.lsp.buf.clear_references })
        end
      end,
    })

    vim.diagnostic.config {
      virtual_text = false,
      float = { border = "rounded", source = true, header = "", prefix = "" },
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
      "black",
      "isort",
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
