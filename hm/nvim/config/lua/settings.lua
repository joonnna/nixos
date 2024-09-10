local o = vim.o

o.showcmd = false
o.ruler = false
o.tabstop = 4
o.shiftwidth = 4
o.expandtab = true
o.lazyredraw = true
o.number = true
o.relativenumber = true
o.undofile = true
o.swapfile = false
o.clipboard = 'unnamedplus'
o.termguicolors = true

-- require 'colorizer'.setup()

-- https://github.com/neovim/neovim/issues/14433
vim.g.loaded_sql_completion = 0
vim.g.omni_sql_default_compl_type = 'syntax'
vim.g.omni_sql_no_default_maps = 1

-- In-order:
-- vim-commentary add sql filetype
-- Remove trailing whitespaces
-- Highlights trailing whitespaces (hightlight and match command)
-- Remembers last edit line of file
vim.cmd([[
augroup autocmds
autocmd!
autocmd FileType terraform setlocal commentstring=//\ %s
autocmd FileType sql setlocal commentstring=--!\ %s
autocmd BufWritePre * %s/\s\+$//e
highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
augroup END
]])

-- Minimizes split bar between windows
-- vim.cmd([[highlight VertSplit guifg=black guibg=black ctermfg=black ctermbg=black]])

vim.cmd [[autocmd BufWritePre * lua  { async = false }]]


local formatting = vim.api.nvim_create_augroup("BufFormatting", {})
vim.api.nvim_create_autocmd({ "BufWritePre" }, {
    group = formatting,
    callback = function()
        vim.lsp.buf.format {
            filter = function(client) return client.name ~= "tsserver" end
        }
    end,
})
