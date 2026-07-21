local actions = require('fzf-lua').actions

require('fzf-lua').setup({
    fzf_colors = true,
    keymap = {
        builtin = {
            ['<C-d>'] = 'preview-page-down',
            ['<C-u>'] = 'preview-page-up',
        },
        fzf = {
            ['ctrl-a'] = 'select-all+accept',
            ['ctrl-e'] = 'down',
            ['ctrl-i'] = 'up',
            ['ctrl-o'] = 'select',
        },

    },
    actions = {
        files = {
            false,
            -- Pickers inheriting these actions:
            --   files, git_files, git_status, grep, lsp, oldfiles, quickfix, loclist,
            --   tags, btags, args, buffers, tabs, lines, blines
            -- `file_edit_or_qf` opens a single selection or sends multiple selection to quickfix
            -- replace `enter` with `file_edit` to open all files/bufs whether single or multiple
            -- replace `enter` with `file_switch_or_edit` to attempt a switch in current tab first
            ["enter"]  = actions.file_edit_or_qf,
            -- ["ctrl-s"] = actions.file_split,
            -- ["ctrl-v"] = actions.file_vsplit,
            -- ["ctrl-t"] = actions.file_tabedit,
            -- ["alt-q"]  = actions.file_sel_to_qf,
            -- ["alt-Q"]  = actions.file_sel_to_ll,
            -- ["alt-f"]  = actions.toggle_follow,
            ["ctrl-i"] = actions.toggle_ignore,
            ["ctrl-g"] = actions.toggle_hidden,
        },
    }
})
