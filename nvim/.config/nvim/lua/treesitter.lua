local configs = require('nvim-treesitter.configs')

configs.setup {
  ensure_installed = {
    "bash",
    "cpp",
    "hack",
    "html",
    "javascript",
    "json",
    "lua",
    "make",
    "python",
    "rust",
    "vim",
  },
  sync_install = false,
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false,
  },
  -- indent = {
  --   enable = true,
  -- },
}

