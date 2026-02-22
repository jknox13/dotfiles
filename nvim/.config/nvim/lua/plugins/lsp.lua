return {
  {
    "nvimtools/none-ls.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
  },
  {
    "neovim/nvim-lspconfig",
    dependencies = { "hrsh7th/cmp-nvim-lsp" },
    config = function()
      local capabilities = require("cmp_nvim_lsp").default_capabilities()

      vim.diagnostic.config({
        virtual_text = true,
        signs = true,
      })

      -- Default capabilities for all servers
      vim.lsp.config("*", {
        capabilities = capabilities,
      })

      -- Buffer-local keymaps on attach
      vim.api.nvim_create_autocmd("LspAttach", {
        callback = function(args)
          local opts = { buffer = args.buf, silent = true }

          vim.keymap.set("n", "<space>e", vim.diagnostic.open_float, opts)
          vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)
          vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts)

          vim.keymap.set("n", "<leader>vca", vim.lsp.buf.code_action, opts)
          vim.keymap.set("n", "<leader>vd", vim.lsp.buf.definition, opts)
          vim.keymap.set("n", "<leader>vh", vim.lsp.buf.hover, opts)
          vim.keymap.set("n", "<leader>vi", vim.lsp.buf.implementation, opts)
          vim.keymap.set("n", "<leader>vsh", vim.lsp.buf.signature_help, opts)
          vim.keymap.set("n", "<leader>vrr", vim.lsp.buf.references, opts)
          vim.keymap.set("n", "<leader>vrn", vim.lsp.buf.rename, opts)
          vim.keymap.set("n", "<leader>vic", vim.lsp.buf.incoming_calls, opts)
          vim.keymap.set("n", "<leader>voc", vim.lsp.buf.outgoing_calls, opts)

          vim.opt_local.signcolumn = "yes:1"
        end,
      })

      vim.lsp.enable("bashls")
    end,
  },
}
