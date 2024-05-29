return {
  "neovim/nvim-lspconfig",
  opts = {
    inlay_hints = {
      enabled = false,
    },
    servers = {
      -- Ensure mason installs the server
      clangd = {
        keys = {
          { "<C-p>", "<cmd>ClangdSwitchSourceHeader<cr>", desc = "Switch Source/Header (C/C++)" },
        },
        root_dir = function(...)
          -- using a root .clang-format or .clang-tidy file messes up projects, so remove them
          return require("lspconfig.util").root_pattern(
            ".git",
            "compile_commands.json",
            "compile_flags.txt",
            "configure.ac"
          )(...)
        end,
        capabilities = {
          offsetEncoding = { "utf-16" },
        },
        cmd = {
          "clangd",
          "--background-index",
          "--clang-tidy",
          "--header-insertion=never",
          "--completion-style=detailed",
          "--function-arg-placeholders",
          "--fallback-style=llvm",
        },
        init_options = {
          usePlaceholders = true,
          completeUnimported = true,
          clangdFileStatus = true,
        },
      },
    },
    -- setup = {
    --   clangd = function(_, opts)
    --     local clangd_ext_opts = require("lazyvim.util").opts("clangd_extensions.nvim")
    --     require("clangd_extensions").setup(vim.tbl_deep_extend("force", clangd_ext_opts or {}, { server = opts }))
    --     return true
    --   end,
    -- },
  },

  init = function()
    local keys = require("lazyvim.plugins.lsp.keymaps").get()
    -- change a keymap
    -- keys[#keys + 1] = { "K", "5<C-y>" }
    -- disable a keymap
    keys[#keys + 1] = { "K", false }
    keys[#keys + 1] = { "gr", false }
    keys[#keys + 1] = { "gd", false }
    -- add a keymap
    -- keys[#keys + 1] = { "H", "<cmd>echo 'hello'<cr>" }
  end,
}
