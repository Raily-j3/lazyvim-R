return {
  { "blazkowolf/gruber-darker.nvim" },
  -- { 'thimc/gruber-darker.nvim' },
  {'sainnhe/everforest',
    init = function()
       vim.g["everforest_background"]= 'hard'
       -- vim.g["everforest_transparent_background"]= 2
       vim.g["everforest_diagnostic_line_highlight"]= 1
       vim.g["everforest_diagnostic_virtual_text"]= 'colored'

    end,
    lazy = false
  },

  -- Configure LazyVim to load gruvbox
  {
    "LazyVim/LazyVim",
    opts = {
      -- colorscheme = "everforest",
      colorscheme = "gruber-darker",
    },
  },
}
