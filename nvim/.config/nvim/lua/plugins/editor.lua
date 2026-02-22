return {
  { "tpope/vim-surround" },
  { "tpope/vim-repeat" },
  { "tpope/vim-abolish" },
  {
    "unblevable/quick-scope",
    init = function()
      vim.g.qs_highlight_on_keys = { "f", "F", "t", "T" }
    end,
  },
  { "ntpeters/vim-better-whitespace" },
}
