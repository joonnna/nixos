local set = vim.keymap.set

local crates = require("crates")

vim.g.mapleader = ' '

-- local silent_opts = { noremap = true, silent = true }
-- local opts = { noremap = true }

-- Keep visual selection when indenting/outdenting
set('v', '>', '>gv')
set('v', '<', '<gv')

set('n', '<C-t>', '<C-w>w')
set('n', '<C-g>', '<C-w>v')

-- Don't go to next word when highlighting
set('n', '*', ':execute "normal! *N"<CR>')
set('n', '#', ':execute "normal! #N"<CR>')

set('n', '<C-s>', ':wa | sus<CR>')

-- Navigation
set('n', 'j', 'gj')
set('n', 'k', 'gk')
set('n', 'J', '10j')
set('n', 'K', '10k')
set('n', '(', ')')
set('n', '{', '}')
set('n', ')', '(')
set('n', '}', '{')
-- set('n', '<C-n>', '<C-d>')
-- set('n', '<C-e>', '<C-u>')

set('n', '<BS>', 'ciw')

set('n', '<leader><leader>', '<c-^>')
set('n', '<leader>,', ':w<CR>')
set('n', '<leader><', ':wqa<CR>')
set('n', '<leader>h', ':q<CR>')
set('n', '<leader>H', ':qa!<CR>')

-- Execute previous command
set('n', ';', ':<UP><CR>')

-- Delete into black hole register
set({ 'n', 'v' }, '<leader>d', '"_d')

-- Dont overwrite clipoard with the deleted text when pasting
set('v', 'p', 'P')

-- Search for selected text
set('v', '/', "y/\\V<C-R>=escape(@\",'/\\')<CR><CR>")

-- Crates
set("n", "<leader>mr", crates.open_repository, { desc = "Open crate repository" })
set("n", "<leader>md", crates.open_documentation, { desc = "Open crate documentation" })
set("n", "<leader>mf", crates.show_features_popup, { desc = "Show crate features" })
set("n", "<leader>mv", crates.show_versions_popup, { desc = "Show crate versions" })
set("n", "<leader>mp", crates.show_dependencies_popup, { desc = "Show crate dependencies" })
set("n", "<leader>mu", crates.upgrade_crate, { desc = "Upgrade crate" })
set("n", "<leader>mU", crates.upgrade_crates, { desc = "Upgrade all crates" })

set('n', '<leader>S', '<cmd>lua require("spectre").toggle()<CR>', { desc = "Toggle Spectre" })

-- -- Fzf
set('n', '<leader>a', ':FzfLua lsp_code_actions<CR>')
set('n', '<leader>t', ':FzfLua files<CR>')
set('n', '<leader>n', ':FzfLua buffers<CR>')
set('n', '<leader>s', ':FzfLua grep_project<CR>')
set('n', '<leader>i', ':FzfLua lsp_live_workspace_symbols<CR>')
set('n', '<leader>e', ':FzfLua lsp_workspace_diagnostics<CR>')
set('n', '<leader>u', ':FzfLua command_history<CR>')
set('n', '<leader>p', ':FzfLua search_history<CR>')
set('n', '<leader>gk', ':FzfLua keymaps<CR>')

set("n", "<leader>o", "<cmd>Oil --float<cr>", { desc = "Open file explorer" })

-- Quickfix list
set('n', '<C-k>', ':cnext<CR>zz')
set('n', '<C-j>', ':cprev<CR>zz')
set('n', '<leader>z', ':cclose<CR>')

-- Tabs
-- set('n', '<leader>t', ':tabnew<CR>')
-- set('n', 't', ':tabn<CR>')
-- set('n', 'T', ':tabp<CR>')

set('n', '<leader>yt', ':norm ysiw<iOption<CR>')
set('n', '<leader>ys', ':norm ysiw)idbg!<CR>')
set('n', '<leader>yr', ':norm ysiw<iResult<CR>')

-- Lsp
set('n', 'gt', function() require('fzf-lua').lsp_typedefs() end)
set('n', 'gd', vim.lsp.buf.definition)
set('n', 'gi', vim.lsp.buf.implementation)
set('n', 'gr', vim.lsp.buf.references)
set('n', '<leader>l', vim.lsp.buf.hover)
set('n', '<leader>r', vim.lsp.buf.rename)
set('n', 't', vim.diagnostic.goto_next)
set('n', 'T', vim.diagnostic.goto_prev)
set('n', '<leader>x', vim.diagnostic.open_float)

set('n', '<leader>c', ':noh<CR>')
set('n', '<leader>gc', function() vim.cmd.RustLsp('openCargo') end)
set('n', '<leader>gp', function() vim.cmd.RustLsp('parentModule') end)



-- Treesitter
-- set('n', '<leader>y', ':TSHighlightCapturesUnderCursor<CR>')
-- set('n', '<leader>Y', ':TSPlaygroundToggle<CR>')
-- set('n', '<leader>y', ':Inspect<CR>')
