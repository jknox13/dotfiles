local lspconfig = require('lspconfig')
local completion = require('completion')

local opts = { noremap=true, silent=true }

local on_attach = function(client)
    completion.on_attach(client)

    -- Mappings.
    vim.api.nvim_set_keymap('n', '<leader>vca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
    vim.api.nvim_set_keymap('n', '<leader>vd',  '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
    vim.api.nvim_set_keymap('n', '<leader>vh',  '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
    vim.api.nvim_set_keymap('n', '<leader>vi',  '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
    vim.api.nvim_set_keymap('n', '<leader>vsh', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
    vim.api.nvim_set_keymap('n', '<leader>vrr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
    vim.api.nvim_set_keymap('n', '<leader>vrn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
    vim.api.nvim_set_keymap('n', '<leader>vic', '<cmd>lua vim.lsp.buf.incoming_calls()<CR>', opts)
    vim.api.nvim_set_keymap('n', '<leader>voc', '<cmd>lua vim.lsp.buf.outgoing_calls()<CR>', opts)

    -- style
    vim.g.completion_matching_strategy_list = {'exact', 'substring', 'fuzzy'}
    vim.g.diagnostic_enable_virtual_text = 1
    vim.g.diagnostic_show_sign = 1
    vim.g.diagnostic_insert_delay = 1
    vim.g.space_before_virtual_text = 10
    vim.opt_local.signcolumn = 'yes:1'
end

local servers = { 'bashls', 'flow', 'pylsp' }
for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    on_attach = on_attach,
    flags = {
      debounce_text_changes = 150,
    }
  }
end
