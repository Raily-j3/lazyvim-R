return {
  "echasnovski/mini.comment",
  event = "VeryLazy",
  opts = {
    options = {
      custom_commentstring = function()
        return vim.bo.commentstring
      end,
      ignore_blank_line = true,
    },
    -- Module mappings. Use `''` (empty string) to disable one.
    mappings = {
      -- Toggle comment (like `gcip` - comment inner paragraph) for both
      -- Normal and Visual modes
      comment = "<leader>/",

      -- Toggle comment on current line
      comment_line = "<leader>/",

      -- Toggle comment on visual selection
      comment_visual = "<leader>/",

      -- Define 'comment' textobject (like `dgc` - delete whole comment block)
      textobject = "<leader>/",
    },
  },
}
