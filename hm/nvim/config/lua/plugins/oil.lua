require("oil").setup({
    prompt_save_on_select_new_entry = false,
    keymaps = {
        ["?"] = "actions.show_help",
        ["<CR>"] = "actions.select",
        ["<C-m>"] = "actions.preview",
        ["<Esc>"] = "actions.close",
        ["<BS>"] = "actions.parent",
    },
})
