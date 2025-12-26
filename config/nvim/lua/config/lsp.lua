vim.lsp.enable({'lua_ls'})
vim.lsp.enable({'nil_ls'})


vim.keymap.set( 'n', '<leader>lf', vim.lsp.buf.format )
