require("nvim-surround").setup({
    surrounds = {
        ["c"] = {
            add = { "COALESCE(", ")" },
        },
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
