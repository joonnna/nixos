require("nvim-surround").setup({
    surrounds = {
        ["c"] = {
            add = { "COALESCE(", ")" },
            find = "COALESCE%b()",
            delete = "^(COALESCE%()().-(%))()$",
        },
        ["d"] = {
            add = { "dbg!(", ")" },
            find = "dbg!%b()",
            delete = "^(dbg!%()().-(%))()$",
        },
        ["u"] = {
            add = { "Result<", ">" },
            find = "Result<().-()>",
            delete = "^(Result<)().-(>)()$",
        },
        ["p"] = {
            add = { "Option<", ">" },
            find = "Option<().-()>",
            delete = "^(Option<)().-(>)()$",
        },
        ["o"] = {
            add = { "Ok(", ")" },
            find = "Ok%b()",
            delete = "^(Ok%()().-(%))()$",
        },
        ["e"] = {
            add = { "Err(", ")" },
            find = "Err%b()",
            delete = "^(Err%()().-(%))()$",
        },
    },
})
