require('plugins/colorscheme')
require('plugins/surround')
require('plugins/flash')
require('plugins/treesitter')

if vim.g.started_by_firenvim then
    require('plugins/firenvim')
else
    require('plugins/lsp')
    require('plugins/formatter')
    require('plugins/fzf')
    require('plugins/oil')
    -- require('plugins/crates')
    require('plugins/fidget')
    require('plugins/spectre')
end
