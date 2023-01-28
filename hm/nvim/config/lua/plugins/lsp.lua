local cmp = require 'cmp'
local opts = { noremap = true, silent = true }

cmp.setup({
    snippet = {
        expand = function(args)
            require('luasnip').lsp_expand(args.body)
        end,
    },
    window = {
        -- completion = cmp.config.window.bordered(),
        -- documentation = cmp.config.window.bordered(),
    },
    mapping = cmp.mapping.preset.insert({
        ['<C-b>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<C-e>'] = cmp.mapping.abort(),
        ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
        -- Next item in completion menu.
        -- If on empty line or not adjacent to a word insert tab, else trigger completion
        ['<Tab>'] = cmp.mapping(function(fallback)
            local col = vim.fn.col('.') - 1
            if cmp.visible() then
                cmp.select_next_item(opts)
            elseif col == 0 or vim.fn.getline('.'):sub(col, col):match('%s') then
                fallback()
            else
                cmp.complete()
            end
        end, { 'i', 's' }),
        -- Previous item in completion menu.
        ['<S-Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
                cmp.select_prev_item(opts)
            else
                fallback()
            end
        end, { 'i', 's' }),
    }),
    sources = cmp.config.sources({
        { name = 'nvim_lsp' },
        { name = 'luasnip' },
        { name = 'nvim_lsp_signature_help' }
    }, {
        { name = 'buffer' },
    }),
    completion = {
        completeopt = 'menu,menuone,noinsert',
    }
})

local capabilities = require('cmp_nvim_lsp').default_capabilities()

-- Update through paru
require('lspconfig')['rust_analyzer'].setup {
    capabilites = capabilites,
    settings = {
        ["rust-analyzer"] = {
            cargo = {
                allFeatures = true,
                allTargets = true,
            },
            checkOnSave = {
                command = "clippy",
                allTargets = true,
                allFeatures = true,
                extraArgs = { "--tests", "--all-targets", "--all-features" },
            }
        }
    }
}

-- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#bicep
local bicep_lsp_bin = "/usr/local/bin/bicep-langserver/Bicep.LangServer.dll"
require 'lspconfig'.bicep.setup {
    capabilities = capabilities,
    cmd = { "dotnet", bicep_lsp_bin };
}

-- paru -S lua-language-server
require 'lspconfig'.sumneko_lua.setup {
    capabilities = capabilities,
}

-- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#yamlls
-- npm install -g yaml-language-server
require('lspconfig').yamlls.setup {
    capabilities = capabilities,
}

-- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#dockerls
-- npm install -g dockerfile-language-server-nodejs
require 'lspconfig'.dockerls.setup {
    capabilites = capabilites,
}

-- https://github.com/denoland/deno
-- Update through cargo install-update
require 'lspconfig'.denols.setup {
    capabilites = capabilites,
    filetypes = { "javascript", "javascriptreact", "javascript.jsx", "typescript", "typescriptreact", "typescript.tsx",
        "markdown", "json" }
}

-- https://github.com/mads-hartmann/bash-language-server
-- npm i -g bash-language-server
-- paru -S shellcheck-bin
require 'lspconfig'.bashls.setup {
    capabilites = capabilites,
}

require 'lspconfig'.rnix.setup {
    capabilites = capabilites,
}
