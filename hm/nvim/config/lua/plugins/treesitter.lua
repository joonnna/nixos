require 'nvim-treesitter'.setup {
    ensure_installed = {},
    auto_install = false,
    highlight = { enable = true }
}

vim.api.nvim_create_autocmd('FileType', {
    pattern = { 'rust', 'sql', 'python', 'markdown', 'lua', 'nix', 'bash', 'nushell', 'yaml', 'javascript', 'terraform', 'docker', 'toml' },
    callback = function() vim.treesitter.start() end,
})

require 'nvim-treesitter-textobjects'.setup {
    select = {
        enable = true,
        -- Automatically jump forward to textobj, similar to targets.vim
        lookahead = true,
    },

    -- swap = {
    --     lookahead = false,
    -- }
}

vim.keymap.set({ "x", "o" }, "af", function()
    require "nvim-treesitter-textobjects.select".select_textobject("@function.outer", "textobjects")
end)

vim.keymap.set({ "x", "o" }, "if", function()
    require "nvim-treesitter-textobjects.select".select_textobject("@function.inner", "textobjects")
end)

vim.keymap.set({ "x", "o" }, "ac", function()
    require "nvim-treesitter-textobjects.select".select_textobject("@class.outer", "textobjects")
end)

vim.keymap.set({ "x", "o" }, "ic", function()
    require "nvim-treesitter-textobjects.select".select_textobject("@class.inner", "textobjects")
end)

local swap = require("nvim-treesitter-textobjects.swap")
vim.keymap.set("n", "<leader>y", function()
    swap.swap_next("@parameter.inner")
end)
