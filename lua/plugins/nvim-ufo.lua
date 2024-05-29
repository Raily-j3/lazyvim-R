return {
  "kevinhwang91/nvim-ufo",
  dependencies = "kevinhwang91/promise-async",
  event = "VeryLazy",
  -- lazy = "disable",
  opts = {
    open_fold_hl_timeout = 400,
    close_fold_kinds_for_ft = {
      default = { "imports", "comment" },
      json = { "array" },
    },
    preview = {
      win_config = {
        border = { "", "─", "", "", "", "─", "", "" },
        -- winhighlight = "Normal:Folded",
        winblend = 0,
      },
    },
  },
  init = function()
    vim.o.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease the value
    vim.o.foldlevelstart = 99
    vim.o.foldenable = true
  end,
  config = function(_, opts)
    require("ufo").setup(opts)
    vim.keymap.set("n", "zR", require("ufo").openAllFolds)
    vim.keymap.set("n", "zM", require("ufo").closeAllFolds)
    vim.keymap.set("n", "zr", require("ufo").openFoldsExceptKinds)
    vim.keymap.set("n", "K", function()
      local winid = require("ufo").peekFoldedLinesUnderCursor()
      if not winid then
        -- vim.lsp.buf.hover()
        vim.cmd([[ Lspsaga hover_doc ]])
      end
    end)
  end,
}
-- return {
--   -- UFO folding
--   {
--     "kevinhwang91/nvim-ufo",
--     dependencies = {
--       "kevinhwang91/promise-async",
--       {
--         "luukvbaal/statuscol.nvim",
--         config = function()
--           local builtin = require("statuscol.builtin")
--           require("statuscol").setup({
--             relculright = true,
--             segments = {
--               { text = { builtin.foldfunc }, click = "v:lua.ScFa" },
--               { text = { "%s" }, click = "v:lua.ScSa" },
--               { text = { builtin.lnumfunc, " " }, click = "v:lua.ScLa" },
--             },
--           })
--         end,
--       },
--     },
--     event = "BufReadPost",
--     opts = {
--       provider_selector = function()
--         -- return { "treesitter", "indent" }
--       end,
--     },

--     init = function()
--       vim.keymap.set("n", "zR", function()
--         require("ufo").openAllFolds()
--       end)
--       vim.keymap.set("n", "zM", function()
--         require("ufo").closeAllFolds()
--       end)
--     end,
--   },
--   -- Folding preview, by default h and l keys are used.
--   -- On first press of h key, when cursor is on a closed fold, the preview will be shown.
--   -- On second press the preview will be closed and fold will be opened.
--   -- When preview is opened, the l key will close it and open fold. In all other cases these keys will work as usual.
--   { "anuvyklack/fold-preview.nvim", dependencies = "anuvyklack/keymap-amend.nvim", config = true },
-- }
