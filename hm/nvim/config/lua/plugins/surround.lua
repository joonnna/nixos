require("nvim-surround").setup({
    surrounds = {
        ["d"] = {
            add = { "dbg!(", ")" },
        },
        ["r"] = {
            add = { "Result<", ">" },
        },
        ["t"] = {
            add = { "Option<", ">" },
        },
        ["o"] = {
            add = { "Ok(", ")" },
        },
        ["e"] = {
            add = { "Err(", ")" },
        },
    },
})
