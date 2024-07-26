local highlight = function(colors)
    for name, opts in pairs(colors) do
        vim.api.nvim_set_hl(0, name, opts)
    end
end

vim.g.colors_name = 'colorscheme'

---------- COLORS ----------


local c = {
    background = '#0a0f14',
    -- bg = '#1c1c1c',
    bg2 = '#303030',
    bg3 = '#121212',
    bg4 = '#2f2f2f',
    fg = '#e0e0e0',
    white = '#ffffff',
    diff_red = '#55393d',
    diff_green = '#394634',
    diff_red_bright = '#71394a',
    diff_green_bright = '#5d7255',
    neon_green = '#39FF14',
    diff_blue = '#354157',
    changed_text = '#4b5c7c',
    border = '#80A0C2',
    teal = '#008080',
    red = '#fc5d7c',
    -- orange = '#fc8c03',
    orange = '#d26939',
    -- orange = '#FF8F40',


    dir = '#168791',

    yellow = '#eeff00',
    light_yellow = '#86dc2f',
    dark_yellow = '#e7c664',
    green = '#50af87',
    light_seagreen = '#20B2AA',
    light_blue = '#7db9d0',
    blue = '#5f97e7',
    bright_purple = '#5D3FD3',
    dark_purple = '#8787d7',
    middle_purple = '#875faf',
    light_purple = '#d787d7',
    purple_red = '#d75faf',
    light_pink = '#ffbbee',
    dark_pink = '#ff97e7',
    grey = '#7f8490',
    magneta = '#990042',
    cyan = '#42fff2',
    hard_blue = '#0000ff',
    sky_blue = '#00bfff'
}

highlight({
    --     ---------- HIGHLIGHTING GROUPS ----------

    -- ColorColumn = { bg = c.background },
    --     Conceal = { fg = c.grey },
    --     Cursor = { reverse = true },
    --     CursorColumn = { bg = c.bg },
    --     CursorLine = { bg = c.bg },
    --     CursorLineHiddenCursor = { fg = c.red },
    CursorLineNr = { fg = c.light_pink },
    --     CursorTransparent = { strikethrough = true, blend = 100 },
    --     DiffAdd = { bg = c.diff_green },
    --     DiffChange = { bg = c.diff_blue },
    --     DiffDelete = { bg = c.diff_red },
    --     DiffText = { bg = c.changed_text },
    -- Directory = { fg = c.blue },
    --     ErrorMsg = { fg = c.red },
    --     FloatBorder = { fg = c.bg4 },
    --     FoldColumn = { fg = c.grey },
    --     Folded = { fg = c.grey, bg = c.bg },
    --     IncSearch = { fg = c.bg, bg = c.red },
    LineNr = { fg = c.light_seagreen },
    --     MatchParen = { fg = c.light_yellow, bg = c.bg },
    --     ModeMsg = { fg = c.fg, bold = true },
    --     MoreMsg = { fg = c.blue, bold = true },
    --     NonText = { fg = c.bg2 },
    --     Normal = { fg = c.fg, bg = c.bg },
    -- NormalFloat = { fg = c.light_blue, bg = c.hard_blue },
    Pmenu = { fg = c.yellow, bg = c.background },
    --     PmenuSbar = { bg = c.bg2 },
    PmenuSel = { fg = c.yellow, bg = c.hard_blue },
    --     PmenuThumb = { bg = c.grey },
    --     Question = { fg = c.dark_yellow },
    --     QuickFixLine = { fg = c.blue, bold = true },
    -- Search = { fg = c.bg, bg = c.light_yellow },
    --     SignColumn = { fg = c.fg },
    --     SpecialKey = { fg = c.bg2 },
    --     SpellBad = { fg = c.red, undercurl = true, sp = c.red },
    --     SpellCap = { fg = c.dark_yellow, undercurl = true, sp = c.dark_yellow },
    --     SpellLocal = { fg = c.blue, undercurl = true, sp = c.blue },
    --     SpellRare = { fg = c.middle_purple, undercurl = true, sp = c.middle_purple },
    --     StatusLine = { fg = c.fg },
    --     StatusLineNC = { fg = c.grey, bg = c.bg },
    --     StatusLineTerm = { fg = c.fg, bg = c.bg2 },
    --     StatusLineTermNC = { fg = c.grey, bg = c.bg },
    --     TabLine = { fg = c.grey, bg = c.bg3 },
    --     TabLineFill = { fg = c.grey, bg = c.bg3 },
    --     TabLineSel = { fg = c.fg, bg = c.bg, italic = true, bold = true },
    VertSplit = { fg = c.background },
    --     Visual = { bg = c.bg2 },
    --     VisualNOS = { bg = c.bg2, underline = true },
    --     WarningMsg = { fg = c.dark_yellow, bold = true },
    --     Whitespace = { bg = c.red },
    --     WildMenu = { link = 'PmenuSel' },
    --     iCursor = { link = 'Cursor' },
    --     lCursor = { link = 'Cursor' },
    --     vCursor = { link = 'Cursor' },

    --     ---------- SYNTAX GROUP NAMES ----------
    --     Boolean = { fg = c.dark_yellow },
    --     Character = { fg = c.dark_yellow },
    Comment = { fg = c.teal, italic = true },
    ['@comment.documentation'] = { fg = c.dir, italic = true },
    --     Conditional = { fg = c.blue },
    Constant = { fg = c.yellow },
    --     Define = { fg = c.red },
    --     Delimiter = { fg = c.fg },
    --     Error = { fg = c.red },
    --     Exception = { fg = c.red },
    --     Float = { fg = c.light_purple },
    Function = { fg = c.neon_green },
    --     Ignore = { fg = c.grey },
    --     Include = { fg = c.red },
    Keyword = { fg = c.cyan },
    --     Label = { fg = c.red },
    Macro = { fg = c.bright_purple },
    --     Number = { fg = c.light_purple },
    Operator = { fg = c.orange },
    --     PreCondit = { fg = c.red },
    --     PreProc = { fg = c.blue },
    --     Repeat = { fg = c.blue },
    Special = { fg = c.light_seagreen },
    -- SpecialChar = { fg = c.middle_purple },
    --     SpecialComment = { fg = c.teal, italic = true },
    Statement = { fg = c.white },
    --     StorageClass = { fg = c.blue },
    String = { fg = c.dir },
    --     Tag = { fg = c.blue },
    --     Title = { fg = c.red, bold = true },
    --     ['@text.note'] = { fg = c.blue, italic = true, bold = true },
    --     ['@text.warning'] = { fg = c.dark_yellow, italic = true, bold = true },
    Type = { fg = c.sky_blue },
    --     Underlined = { underline = true },

    --     ---------- TREESITTER ----------
    --     ['@constructor'] = { fg = c.light_pink },
    ['@constant.builtin'] = { fg = c.orange },
    -- ['@custom.type'] = { fg = c.light_seagreen },
    ['@field'] = { fg = c.white },
    --     ['@function.builtin'] = { link = 'Function' },
    --     ['@function.call'] = { link = 'Function' },
    ['@function.macro'] = { link = 'Macro' },
    --     ['@keyword.conditional'] = { link = 'Conditional' },
    --     ['@keyword.import'] = { link = 'Include' },
    --     ['@keyword.return'] = { fg = c.blue },
    --     ['@keyword.repeat'] = { fg = c.blue },
    ['@module'] = { link = '@namespace' },
    ['@namespace'] = { fg = c.light_seagreen },
    --     ['@note'] = { fg = c.blue, bold = true },
    -- ['@parameter'] = { fg = c.blue },
    --     ['@parameter.reference'] = { link = '@parameter' },
    --     ['@property'] = { fg = c.dark_purple },
    --     ['@punctuation.special'] = { fg = c.red },
    --     ['@string.escape'] = { link = 'String' },
    --     ['@tag'] = { link = 'Tag' },
    --     ['@tag.attribute'] = { fg = c.dark_purple },
    --     ['@tag.delimiter'] = { fg = c.light_pink },
    -- ['@type.builtin'] = { fg = c.neon_green },
    --     ['@type.qualifier'] = { link = '@keyword' },
    ['@variable'] = { fg = c.white },
    -- ['@variable.builtin'] = { fg = c.neon_green },
    --     ['@variable.member'] = { link = '@property' },
    --     ['@comment.todo'] = { fg = c.dark_yellow, bold = true },
    --     ['@comment.note'] = { fg = c.blue, bold = true },
    --     ['@comment.error'] = { fg = c.red, bold = true },

    --     ---------- RUST ----------
    ['@variable.member.rust'] = { link = '@field' },
    ['@variable.member.parameter'] = { fg = c.blue },

    --     ---------- TYPESCRIPT ----------
    --     typescriptParenExp = { link = '@punctBracket' },
    --     typescript1 = { link = '@punctBracket' },
    --     typescriptParens = { link = '@punctBracket' },

    -- ---------- NVIM LSPCONFIG ----------
    -- DiagnosticError = { fg = c.red },
    -- DiagnosticHint = { fg = c.fg },
    -- DiagnosticInfo = { fg = c.dark_yellow },
    -- DiagnosticWarn = { fg = c.orange },
    -- DiagnosticUnderlineError = { link = 'ErrorText' },
    -- DiagnosticUnderlineHint = { link = 'HintText' },
    -- DiagnosticUnderlineInfo = { link = 'InfoText' },
    -- DiagnosticUnderlineWarn = { link = 'WarningText' },
    -- LspSignatureActiveParameter = { fg = c.red },
    -- LspReferenceText = { bg = c.bg2 },
    -- LspReferenceRead = { bg = c.bg2 },
    -- LspReferenceWrite = { bg = c.bg2 },

    --     ---------- HELP ----------
    --     helpCommand = { fg = c.dark_yellow },
    --     helpExample = { fg = c.green },

    -- ---------- CMP ----------
    -- CmpCompletionWindow = { bg = c.background },
    -- CmpItemAbbrMatch = { fg = c.middle_purple },
    -- CmpItemKind = { fg = c.blue },
    -- CmpItemKindClass = { fg = c.blue },
    -- CmpItemKindColor = { fg = c.dark_yellow },
    -- CmpItemKindConstant = { link = '@constant' },
    -- CmpItemKindConstructor = { link = '@constructor' },
    -- CmpItemKindEnum = { fg = c.blue },
    -- CmpItemKindEnumMember = { fg = c.middle_purple },
    -- CmpItemKindEvent = { fg = c.red },
    -- CmpItemKindField = { link = '@field' },
    -- CmpItemKindFile = { fg = c.dark_yellow },
    -- CmpItemKindFolder = { fg = c.dark_yellow },
    -- CmpItemKindFunction = { link = '@function' },
    -- CmpItemKindInterface = { fg = c.blue },
    -- CmpItemKindKeyword = { link = '@keyword' },
    -- CmpItemKindMethod = { link = '@method' },
    -- CmpItemKindModule = { fg = c.blue },
    -- CmpItemKindOperator = { link = '@operator' },
    -- CmpItemKindProperty = { link = '@property' },
    -- CmpItemKindReference = { fg = c.dark_yellow },
    -- CmpItemKindSnippet = { fg = c.dark_yellow },
    -- CmpItemKindStruct = { link = '@type' },
    -- CmpItemKindText = { fg = c.fg },
    -- CmpItemKindTypeParameter = { link = '@type' },
    -- CmpItemKindUnit = { fg = c.middle_purple },
    -- CmpItemKindValue = { fg = c.middle_purple },
    -- CmpItemKindVariable = { link = '@variable' },

    --     ---------- MARKDOWN ----------
    --     ['@text.h1'] = { fg = c.red, bold = true },
    --     ['@text.h2'] = { fg = c.orange, bold = true },
    --     ['@text.h3'] = { fg = c.dark_yellow, bold = true },
    --     ['@text.h4'] = { fg = c.green, bold = true },
    --     ['@text.h5'] = { fg = c.blue, bold = true },
    --     ['@text.h6'] = { fg = c.purple4, bold = true },
    --     ['@text.uri'] = { fg = c.blue, underline = true },
    --     ['@text.reference'] = { fg = c.red },

    --     ---------- SQL ----------
    --     ['@sql.parameter'] = { fg = c.light_blue },
})
