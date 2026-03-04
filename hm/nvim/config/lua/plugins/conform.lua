require("conform").setup({
    formatters_by_ft = {
        javascript = { "prettier" },
        typescript = { "prettier" },
        typescriptreact = { "prettier" },
        javascriptreact = { "prettier" },
        html = { "prettier" },
        css = { "prettier" },
        scss = { "prettier" },
        json = { "prettier" },
        markdown = { "prettier" },
        yaml = { "prettier" },
        sql = { "sql_formatter_dynamic" },
        ["*"] = { "injected" }
    },

    format_on_save = {
        lsp_fallback = true,
    },

    formatters = {
        prettier = {
            command = "prettier",
            args = { "--stdin-filepath", "$FILENAME" },
            stdin = true,
        },

        sql_formatter_dynamic = {
            command = "sql-formatter",
            args = function(ctx)
                local config = vim.fs.find(".sql-formatter.json", {
                    upward = true,
                    path = ctx.dirname,
                })[1]

                if config then
                    return { "--config", config }
                else
                    return { "-l", "postgresql" }
                end
            end,
            stdin = true,
        },
    },
})
