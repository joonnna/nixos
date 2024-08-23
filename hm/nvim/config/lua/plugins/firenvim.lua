vim.g.firenvim_config = {
    globalSettings = { alt = "all" },
    localSettings = {
        [".*"] = {
            cmdline  = "firenvim",
            content  = "text",
            priority = 0,
            selector = "textarea",
            takeover = "always"
        }
    }
}


vim.o.laststatus = 0
vim.api.nvim_set_keymap("n", "<Esc><Esc>", "<Cmd>call firenvim#focus_page()<CR>", {})

vim.api.nvim_create_autocmd('BufEnter', {
    pattern = "*",
    command = [[nnoremap <CR> :wq<CR>]],
})
vim.api.nvim_create_autocmd({ 'BufEnter' }, {
    pattern = "github.com_*.txt",
    command = "set filetype=markdown"
})
