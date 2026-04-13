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
            ["<c-d>"] = actions.delete_buffer + actions.move_to_top,
            ["<c-w>"] = actions.delete_buffer,
          },
        },
      },
    }

    local builtin = require "telescope.builtin"
    vim.keymap.set("n", "<leader>fk", builtin.keymaps, {})
    vim.keymap.set("n", "<leader>ff", builtin.find_files, {})
    vim.keymap.set("n", "<leader>fo", builtin.oldfiles, {})
    vim.keymap.set("n", "<leader>fs", builtin.builtin, {})
    vim.keymap.set("n", "<leader>fq", builtin.quickfix, {})
    vim.keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "Telescope help tags" })
    vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "Telescope buffers" })

    -- Rip grep + Fzf
    vim.keymap.set("n", "<leader>fg", function()
      builtin.grep_string { search = vim.fn.input "Grep > " }
    end)

    -- Find instance instance of current view being included
    vim.keymap.set("n", "<leader>fc", function()
      local filename_without_extension = vim.fn.expand "%:t:r"
      builtin.grep_string { search = filename_without_extension }
    end, { desc = "Find current file: " })

    -- Grep current string (for when gd doesn't work)
    -- vim.keymap.set("n", "<leader>fs", function()
    --   builtin.grep_string {}
    -- end, { desc = "Find current string: " })

    -- find files in vim config
    vim.keymap.set("n", "<leader>fi", function()
      builtin.find_files { cwd = "~/.config/nvim/" }
    end)
    vim.keymap.set("n", "<leader>s/", function()
      builtin.live_grep {
        grep_open_files = true,
        prompt_title = "Live Grep in Open Files",
      }
    end, { desc = "Search in Open Files" })
    vim.keymap.set("n", "<leader>/", function()
      -- You can pass additional configuration to Telescope to change the theme, layout, etc.
      builtin.current_buffer_fuzzy_find(require("telescope.themes").get_dropdown {
        winblend = 10,
        previewer = false,
      })
    end, { desc = "Fuzzily search in current buffer" })
  end,
}
