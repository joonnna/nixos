local set = vim.keymap.set
set('n', '<leader>z', ':FzfLua ')

vim.g.mapleader = ' '

-- local silent_opts = { noremap = true, silent = true }
-- local opts = { noremap = true}

-- Keep visual selection when indenting/outdenting
set('v', '>', '>gv')
set('v', '<', '<gv')

set('n', '<C-s>', ':sus<CR>')
-- TODO: make i/v modes work
set('i', '<C-s>', ':sus<CR>')
set('v', '<C-s>', ':sus<CR>')

set('n', 'j', 'gj')
set('n', 'k', 'gk')
set('n', 'J', '10j')
set('n', 'K', '10k')

set('n', '<leader>c', ':noh<CR>')
set('n', '<leader><leader>', '<c-^>')
set('n', '<leader>w', ':w<CR>')
set('n', '<leader>q', ':q<CR>')
set('n', '<leader>e', ':Explore<CR>')
set('n', '<leader>E', ':tabedit<CR>:Explore<CR>')

-- Delete into black hole register
set({ 'n', 'v' }, '<leader>d', '"_d')

-- Files
set('n', '<leader>b', ':wa | sus<CR>')

-- -- Fzf
set('', '<leader>f', ':FzfLua files<CR>')
set('n', '<leader>n', ':FzfLua buffers<CR>')
set('n', '<leader>s', ':FzfLua grep_project<CR>')
set('n', '<leader>d', ':FzfLua lsp_workspace_diagnostics<CR>')
set('n', '<leader>a', ':FzfLua lsp_code_actions<CR>')
set('n', '<leader>y', ':FzfLua command_history<CR>')
set('n', '<leader>p', ':FzfLua search_history<CR>')

-- Tabs
set('n', '<leader>t', ':tabnew<CR>')
set('n', 't', ':tabn<CR>')
set('n', 'T', ':tabp<CR>')

-- Lsp
set('n', 'gd', vim.lsp.buf.definition)
set('n', 'gi', vim.lsp.buf.implementation)
set('n', 'gr', vim.lsp.buf.references)
set('n', '<leader>o', vim.lsp.buf.hover)
set('n', '<leader>r', vim.lsp.buf.rename)
set('n', 'ck', vim.diagnostic.goto_prev)
set('n', 'cj', vim.diagnostic.goto_next)
set('n', '<leader>x', vim.diagnostic.open_float)
