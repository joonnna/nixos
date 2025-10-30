require('flash').setup({
    modes = {
        char = {
            enabled = true, -- enabling the expanded find mode
            keys = { 'f', 'F' }
        },
    },
})

vim.keymap.set('n', 's', '<cmd>lua require("flash").jump()<CR>')
vim.api.nvim_set_hl(0, 'FlashLabel', { fg = '#39FF14', bold = true })
