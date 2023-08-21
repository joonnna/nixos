local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

require("formatter").setup({
    filetype = {
        sql = function()
            local config = reverse_find_file('.sql-formatter.json')
            return {
                exe = "sql-formatter",
                args = config == nil and { "-l", "postgresql" } or { '--config', config }
            }
        end,
    },
})

local function format()
    vim.cmd.FormatWrite('injections')
end

vim.keymap.set('n', '<leader>x', format)


local group2 = augroup("Formatter2", {})
autocmd("BufWritePost", {
    pattern = {
        "*.sql",
    },
    group = group2,
    callback = function()
        if not vim.b.disable_formatting then
            vim.cmd.FormatWrite()
        end
    end,
    desc = "Formatting",
})

function _reverse_find_file(file, dir)
    local files = get_os_command_output({ 'ls', '-a1' }, dir)
    for _, x in pairs(files) do
        if x == file then
            return dir .. '/' .. file
        end
    end

    if dir == '/' then
        return nil
    else
        return _reverse_find_file(file, path_pop(dir))
    end
end

function reverse_find_file(file) return _reverse_find_file(file, path_pop(vim.api.nvim_buf_get_name(0))) end

function get_os_command_output(cmd, cwd)
    local result = {}
    local job = vim.fn.jobstart(cmd, {
        cwd = cwd,
        stdout_buffered = true,
        on_stdout = function(_, output, _) result = output end,
    })
    vim.fn.jobwait({ job })

    return result
end

function path_pop(path)
    local new_path, _ = string.gsub(path, '/[^/]+$', '')
    return new_path == '' and '/' or new_path
end
