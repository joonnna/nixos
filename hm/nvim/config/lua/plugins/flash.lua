local set = vim.keymap.set

--{
--  "folke/flash.nvim",
--  event = "VeryLazy",
--  ---@type Flash.Config
--  opts = {},
--  -- stylua: ignore
--  keys = {
--    { "s", mode = { "n", "x", "o" }, function() require("flash").jump() end, desc = "Flash" },
--    { "S", mode = { "n", "x", "o" }, function() require("flash").treesitter() end, desc = "Flash Treesitter" },
--    { "r", mode = "o", function() require("flash").remote() end, desc = "Remote Flash" },
--    { "R", mode = { "o", "x" }, function() require("flash").treesitter_search() end, desc = "Treesitter Search" },
--    { "<c-s>", mode = { "c" }, function() require("flash").toggle() end, desc = "Toggle Flash Search" },
--  },
--}

require('flash').setup({
    modes = {
        char = {
            enabled = true, -- enabling the expanded find mode
            keys = { 'f', 'F' }
        },
    },
})


set('n', 's', '<cmd>lua require("flash").jump()<CR>')
vim.api.nvim_set_hl(0, 'FlashLabel', { fg = '#39FF14', bold = true })
