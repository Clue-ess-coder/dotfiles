return {
  "nvim-telescope/telescope.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
  config = function()
    local actions = require "telescope.actions"
    require("telescope").setup {
      defaults = {
        mappings = {
          i = {
            ["<C-p>"] = actions.move_selection_previous, -- move to prev result
            ["<C-n>"] = actions.move_selection_next, -- move to next result
            ["<C-q>"] = actions.send_selected_to_qflist + actions.open_qflist, -- send selected to quickfixlist
            ["<C-d>"] = actions.delete_buffer + actions.move_to_top, -- delete buffer and move to top of list
            ["<C-w>"] = actions.delete_buffer, -- delete buffer alone
            ["<A-j>"] = actions.close, -- close buffer
          },
        },
      },
    }

    local builtin = require "telescope.builtin"
    vim.keymap.set("n", "<leader><leader>", builtin.find_files, { desc = "Telescope find files" })
    vim.keymap.set("n", "<leader>e", builtin.buffers, { desc = "Telescope buffers" })

    vim.keymap.set("n", "<leader>sk", builtin.keymaps, { desc = "Telescope keymaps" })
    vim.keymap.set("n", "<leader>so", builtin.oldfiles, { desc = "Telescope old files" })
    vim.keymap.set("n", "<leader>sc", builtin.builtin, { desc = "Telescope builtin commands" })
    vim.keymap.set("n", "<leader>sq", builtin.quickfix, { desc = "Telescope quickfix list" })
    vim.keymap.set("n", "<leader>sh", builtin.help_tags, { desc = "Telescope help tags" })

    vim.keymap.set("n", "<leader>sb", function()
      -- You can pass additional configuration to Telescope to change the theme, layout, etc.
      builtin.current_buffer_fuzzy_find(require("telescope.themes").get_dropdown {
        winblend = 10,
        previewer = false,
      })
    end, { desc = "Fuzzily search in current buffer" })

    vim.keymap.set("n", "<leader>ss", function()
      builtin.live_grep {
        grep_open_files = true,
        prompt_title = "Live grep in all open files",
      }
    end, { desc = "Fuzzily Search in all open files" })

    vim.keymap.set("n", "<leader>fi", function()
      builtin.find_files { cwd = "~/.config/nvim/" }
    end, { desc = "Find files in Neovim config" })

    -- vim.keymap.set("n", "<leader>sg", function()
    --   builtin.grep_string { search = vim.fn.input "Grep > " }
    -- end, { desc = "Grep in Current File" })
    --
    -- vim.keymap.set("n", "<leader>sw", function()
    --   local filename_without_extension = vim.fn.expand "%:t:r"
    --   builtin.grep_string { search = filename_without_extension }
    -- end, { desc = "Search word" })

    -- Grep current string (for when gd doesn't work)
    -- vim.keymap.set("n", "<leader>sw", function()
    --   builtin.grep_string {}
    -- end, { desc = "Find current string: " })
  end,
}
