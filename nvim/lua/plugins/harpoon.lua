return {
  "ThePrimeagen/harpoon",
  branch = "harpoon2",
  dependencies = { "nvim-lua/plenary.nvim", "nvim-telescope/telescope.nvim" },
  config = function()
    local harpoon = require "harpoon"

    -- REQUIRED for Harpoon 2
    harpoon:setup {}

    -- --- Telescope Integration ---
    local conf = require("telescope.config").values
    local function toggle_telescope(harpoon_files)
      local file_paths = {}
      for _, item in ipairs(harpoon_files.items) do
        table.insert(file_paths, item.value)
      end

      require("telescope.pickers")
        .new(require("telescope.themes").get_ivy(), {
          prompt_title = "Harpoon",
          finder = require("telescope.finders").new_table {
            results = file_paths,
          },
          previewer = conf.file_previewer {},
          sorter = conf.generic_sorter {},
        })
        :find()
    end

    -- --- Keymaps ---
    vim.keymap.set("n", "<leader>a", function()
      harpoon:list():add()
    end, { desc = "Harpoon Add" })

    vim.keymap.set("n", "<leader>r", function()
      harpoon:list():remove()
    end, { desc = "Harpoon Remove" })

    -- Standard Harpoon UI
    vim.keymap.set("n", "<C-e>", function()
      harpoon.ui:toggle_quick_menu(harpoon:list())
    end)

    -- Telescope UI
    vim.keymap.set("n", "<leader>fl", function()
      toggle_telescope(harpoon:list())
    end, { desc = "Open Harpoon Telescope" })

    -- Navigation
    vim.keymap.set("n", "<C-p>", function()
      harpoon:list():prev()
    end)
    vim.keymap.set("n", "<C-n>", function()
      harpoon:list():next()
    end)

    -- Direct Access (The real power of Harpoon)
    vim.keymap.set("n", "<leader>1", function()
      harpoon:list():select(1)
    end)
    vim.keymap.set("n", "<leader>2", function()
      harpoon:list():select(2)
    end)
  end,
}
