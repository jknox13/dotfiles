return {
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons",
    },
    keys = {
      { "<leader>f", "<cmd>Telescope find_files<CR>", desc = "Find files" },
      { "<leader>b", "<cmd>Telescope buffers<CR>", desc = "Buffers" },
      { "<leader>m", "<cmd>Telescope marks<CR>", desc = "Marks" },
      { "<leader>rg", "<cmd>Telescope live_grep<CR>", desc = "Live grep" },
    },
  },
}
