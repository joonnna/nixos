local o = vim.o

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

-- In-order:
-- Remove trailing whitespaces
-- Highlights trailing whitespaces (hightlight and match command)
-- Remembers last edit line of file
vim.cmd([[
augroup autocmds
autocmd!
autocmd BufWritePre * %s/\s\+$//e
highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
augroup END
]])

-- Minimizes split bar between windows
vim.cmd([[highlight VertSplit guifg=black guibg=black ctermfg=black ctermbg=black]])

vim.cmd [[autocmd BufWritePre * lua vim.lsp.buf.format { async = false }]]
