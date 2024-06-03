return {
  "nvim-telescope/telescope.nvim",
  -- dependencies = {
  --   "nvim-telescope/telescope-fzf-native.nvim",
  --   build = "make",
  --   config = function()
  --     require("telescope").load_extension("fzf")
  --   end,
  -- },

  config = function()
    local actions = require("telescope.actions")
    -- don't preview binary file
    local previewers = require("telescope.previewers")
    local Job = require("plenary.job")
    local new_maker = function(filepath, bufnr, opts)
      filepath = vim.fn.expand(filepath)
      Job:new({
        command = "file",
        args = { "--mime-type", "-b", filepath },
        on_exit = function(j)
          local mime_type = vim.split(j:result()[1], "/")[1]
          if mime_type == "text" then
            previewers.buffer_previewer_maker(filepath, bufnr, opts)
          else
            -- maybe we want to write something to the buffer here
            vim.schedule(function()
              vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, { "BINARY" })
            end)
          end
        end,
      }):sync()
    end

    require("telescope").setup({
      defaults = {
        results_title = false,
        sorting_strategy = "ascending", -- display results top->bottom
        layout_config = {
          horizontal = {
            width = 0.9,
            prompt_position = "top",
            preview_width = 0.6,
          },
        },
        buffer_previewer_maker = new_maker, -- don't preview binary file
        mappings = {
          i = {
            ["<C-j>"] = actions.move_selection_next,
            ["<C-k>"] = actions.move_selection_previous,
            ["<C-p>"] = actions.cycle_history_prev,
            ["<C-n>"] = actions.cycle_history_next,
            ["<C-q>"] = actions.send_selected_to_qflist + actions.open_qflist,
          },
        },
      },
      pickers = {
        find_files = {
          theme = "dropdown",
          layout_config = {
            center = { width = 0.5, height = 0.5 },
          },
          previewer = false,
          -- find_command = { "fd", "-H" , "-I"},  -- "-H" search hidden files, "-I" do not respect to gitignore
          find_command = { "fd" }, -- "-H" search hidden files, "-I" do not respect to gitignore
          -- find_command = { "find", "-type", "f" },
        },
        git_files = {
          theme = "dropdown",
          layout_config = {
            center = { width = 0.5, height = 0.5 },
          },
          previewer = false,
          find_command = { "fd", "-H", "-I" }, -- "-H" search hidden files, "-I" do not respect to gitignore
          -- find_command = { "find", "-type", "f" },
        },
        oldfiles = {
          theme = "dropdown",
          layout_config = {
            center = { width = 0.5, height = 0.5 },
          },
          previewer = false,
          find_command = { "fd", "-H", "-I" }, -- "-H" search hidden files, "-I" do not respect to gitignore
          -- find_command = { "find", "-type", "f" },
        },
      },
    })
  end,

  keys = {
    { "<leader>/", false },
    {
      "<leader>.",
      function()
        require("telescope.builtin").live_grep()
      end,
      desc = "Grep",
    },
    {
      "<leader>r",
      function()
        require("telescope.builtin").oldfiles()
      end,
      desc = "Recent",
    },
    {
      "<leader>n",
      function()
        require("telescope.builtin").lsp_document_symbols({
          symbols = {
            "Class",
            "Function",
            "Method",
            "Constructor",
            "Interface",
            "Module",
            "Struct",
            "Trait",
            "Field",
            "Property",
            "Enum",
          },
        })
      end,
      desc = "Goto Symbol",
    },
  },
}
