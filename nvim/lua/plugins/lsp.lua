return {
  "neovim/nvim-lspconfig",
  dependencies = {
    { "mason-org/mason.nvim", opts = {} },
    "mason-org/mason-lspconfig.nvim",
    "WhoIsSethDaniel/mason-tool-installer.nvim",
    { "j-hui/fidget.nvim", opts = {} },
    "saghen/blink.cmp",
    -- Add this for better Lua development!
    { "folke/lazydev.nvim", opts = {} },
  },
  config = function()
    vim.api.nvim_create_autocmd("LspAttach", {
      group = vim.api.nvim_create_augroup("kickstart-lsp-attach", { clear = true }),
      callback = function(event)
        local map = function(keys, func, desc, mode)
          mode = mode or "n"
          vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = "LSP: " .. desc })
        end

        -- Keymaps (simplified references to telescope)
        local builtin = require "telescope.builtin"
        map("grn", vim.lsp.buf.rename, "[R]e[n]ame")
        map("gra", vim.lsp.buf.code_action, "Code Action", { "n", "x" })
        map("grr", builtin.lsp_references, "Goto References")
        map("gri", builtin.lsp_implementations, "Goto Implementation")
        map("grd", builtin.lsp_definitions, "Goto Definition")
        map("gO", builtin.lsp_document_symbols, "Document Symbols")

        -- Highlight symbol under cursor
        local client = vim.lsp.get_client_by_id(event.data.client_id)
        if client and client.supports_method "textDocument/documentHighlight" then
          local group = vim.api.nvim_create_augroup("lsp-highlight", { clear = false })
          vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
            buffer = event.buf,
            group = group,
            callback = vim.lsp.buf.document_highlight,
          })
          vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
            buffer = event.buf,
            group = group,
            callback = vim.lsp.buf.clear_references,
          })
        end
      end,
    })

    -- Diagnostic UI
    vim.diagnostic.config {
      severity_sort = true,
      float = { border = "rounded" },
    }

    -- Server Configurations
    local capabilities = require("blink.cmp").get_lsp_capabilities()
    local servers = {
      lua_ls = {
        settings = {
          Lua = {
            completion = { callSnippet = "Replace" },
            -- You can actually remove 'diagnostics = { globals = {"vim"} }'
            -- because lazydev.nvim handles it better!
          },
        },
      },
      -- Add more servers here (e.g., pyright = {}, tsserver = {})
    }

    -- Mason & Server Setup
    local ensure_installed = vim.tbl_keys(servers)
    vim.list_extend(ensure_installed, { "stylua" })

    require("mason-tool-installer").setup { ensure_installed = ensure_installed }

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
