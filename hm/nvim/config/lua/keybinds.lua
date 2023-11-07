local map = vim.api.nvim_set_keymap

vim.g.mapleader = ' '

local silent_opts = { noremap = true, silent = true }

map('n', '<C-s>', ':sus<CR>', { noremap = true })
-- TODO: make i/v modes work
map('i', '<C-s>', ':sus<CR>', { noremap = true })
map('v', '<C-s>', ':sus<CR>', { noremap = true })

map('n', 'j', 'gj', { noremap = true })
map('n', 'k', 'gk', { noremap = true })
map('n', 'J', '10j', { noremap = true })
map('n', 'K', '10k', { noremap = true })

map('n', '<leader>c', ':noh<CR>', { noremap = false })
map('n', '<leader><leader>', '<c-^>', { noremap = true })
map('n', '<leader>w', ':w<CR>', { noremap = true })
map('n', '<leader>q', ':q<CR>', { noremap = true })
map('n', '<leader>e', ':Explore<CR>', { noremap = true })
map('n', '<leader>E', ':tabedit<CR>:Explore<CR>', { noremap = true })

-- Fzf
map('', '<leader>f', ':FzfLua files<CR>', { noremap = false })
map('n', '<leader>n', ':FzfLua buffers<CR>', { noremap = false })
map('n', '<leader>s', ':FzfLua grep_project<CR>', { noremap = false })
map('n', '<leader>d', ':FzfLua lsp_workspace_diagnostics<CR>', { noremap = false })
map('n', '<leader>a', ':FzfLua lsp_code_actions<CR>', { noremap = false })
map('n', '<leader>z', ':FzfLua ', { noremap = false })
map('n', '<leader>h', ':FzfLua command_history<CR>', { noremap = false })
map('n', '<leader>p', ':FzfLua search_history<CR>', { noremap = false })

-- Tabs
map('n', '<leader>t', ':tabnew<CR>', { noremap = true })
map('n', 't', ':tabn<CR>', { noremap = true })
map('n', 'T', ':tabp<CR>', { noremap = true })

-- Lsp
vim.keymap.set('n', 'gd', vim.lsp.buf.definition, silent_opts)
vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, silent_opts)
vim.keymap.set('n', 'gr', vim.lsp.buf.references, silent_opts)
vim.keymap.set('n', '<leader>o', vim.lsp.buf.hover, silent_opts)
vim.keymap.set('n', '<leader>r', vim.lsp.buf.rename, silent_opts)
vim.keymap.set('n', 'ck', vim.diagnostic.goto_prev, silent_opts)
vim.keymap.set('n', 'cj', vim.diagnostic.goto_next, silent_opts)
vim.keymap.set('n', '<leader>x', vim.diagnostic.open_float, silent_opts)
