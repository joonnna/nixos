local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

require("formatter").setup({
    filetype = {
        sql = function()
            return {
                exe = "sql-formatter",
                args = { "-l", "postgresql" },
            }
        end,
    },
})

local group = augroup("Formatter", {})
autocmd("BufWritePost", {
    pattern = {
        "*.rs",
        "*.sql",
    },
    group = group,
    callback = function()
        if not vim.b.disable_formatting then
            vim.cmd.FormatWrite("injections")
        end
    end,
    desc = "Formatting",
})
