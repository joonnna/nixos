require("oil").setup({
    auto_close_deleted_buffers = true,
    prompt_save_on_select_new_entry = false,
    lsp = {
        timeout_ms = 3000,
        autosave_changes = true,
    },
    keymaps = {
        ["?"] = "actions.show_help",
        ["<CR>"] = "actions.select",
        ["<C-m>"] = "actions.preview",
        ["<Esc>"] = "actions.close",
        ["<BS>"] = "actions.parent",
    },
})
