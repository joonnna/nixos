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
        { name = 'nvim_lsp_signature_help' },
        { name = 'buffer' },
        { name = 'path' },
    }),
    completion = {
        completeopt = 'menu,menuone,noinsert',
    }
})


require('lspconfig')['rust_analyzer'].setup {
    on_attach = function(client, buffnr)
        if client.server_capabilities ~= nil then
            client.server_capabilities.semanticTokensProvider = nil
        end
    end,
    settings = {
        ["rust-analyzer"] = {
            cargo = {
                allFeatures = true,
                allTargets = true,
                extraEnv = {
                    CARGO_TARGET_DIR = '/home/jon/workspace/rust-target'
                },
            },
            check = {
                command = "clippy",
                allTargets = true,
                allFeatures = true,
                extraArgs = { "--tests" }
            }
        }
    }
}

-- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#bicep
local bicep_lsp_bin = "/usr/local/bin/bicep-langserver/Bicep.LangServer.dll"
require 'lspconfig'.bicep.setup {
    cmd = { "dotnet", bicep_lsp_bin },
}

require 'lspconfig'.lua_ls.setup {}

-- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#yamlls
require('lspconfig').yamlls.setup {
    settings = {
        yaml = {
            trace = {
                server = "verbose"
            },
            schemas = {
                ["https://json.schemastore.org/github-workflow.json"] = "/.github/workflows/*",
                kubernetes = "/*.yaml",
            },
            schemaDownload = { enable = true },
            validate = true
        },
    }
}

-- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#dockerls
require 'lspconfig'.dockerls.setup {}

-- https://github.com/denoland/deno
require 'lspconfig'.denols.setup {
    filetypes = { "javascript", "javascriptreact", "javascript.jsx", "typescript", "typescriptreact", "typescript.tsx",
        "markdown", "json" }
}

-- https://github.com/mads-hartmann/bash-language-server
require 'lspconfig'.bashls.setup {}

require 'lspconfig'.taplo.setup {}

require 'lspconfig'.terraformls.setup {}

require 'lspconfig'.pyright.setup {}

require 'lspconfig'.nil_ls.setup {
    autostart = true,
    settings = {
        ['nil'] = {
            formatting = {
                command = { "nixpkgs-fmt" },
            },
        },
    },

}
