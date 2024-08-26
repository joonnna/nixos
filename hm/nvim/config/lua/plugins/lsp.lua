local cmp = require 'cmp'
local opts = { noremap = true, silent = true }


local cmp_select = { behavior = cmp.SelectBehavior.Select }

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
        ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
        ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
        ['<Tab>'] = nil,
        ['<S-Tab>'] = nil,
    }),
    sources = cmp.config.sources({
        { name = 'nvim_lsp' },
        { name = 'luasnip' },
        { name = 'nvim_lsp_signature_help' },
        { name = 'buffer' },
        { name = 'path' },
        { name = 'crates' },
    }),
    completion = {
        completeopt = 'menu,menuone,noinsert',
    }
})

local capabilities = require('cmp_nvim_lsp').default_capabilities()

require('lspconfig')['rust_analyzer'].setup {
    capabilities = capabilities,
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
    capabilities = capabilities,
    cmd = { "dotnet", bicep_lsp_bin },
}

require 'lspconfig'.lua_ls.setup {
    capabilities = capabilities,
}

-- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#yamlls
require('lspconfig').yamlls.setup {
    capabilities = capabilities,
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
require 'lspconfig'.dockerls.setup {
    capabilities = capabilities,
}

-- https://github.com/denoland/deno
require 'lspconfig'.denols.setup {
    capabilities = capabilities,
    filetypes = { "javascript", "javascriptreact", "javascript.jsx", "typescript", "typescriptreact", "typescript.tsx",
        "markdown", "json" }
}

-- https://github.com/mads-hartmann/bash-language-server
require 'lspconfig'.bashls.setup {
    capabilities = capabilities,
}

require 'lspconfig'.taplo.setup {
    capabilities = capabilities,
}

require 'lspconfig'.terraformls.setup {
    capabilities = capabilities,
}

require 'lspconfig'.pyright.setup {
    capabilities = capabilities,
}

require 'lspconfig'.nil_ls.setup {
    capabilities = capabilities,
    autostart = true,
    settings = {
        ['nil'] = {
            formatting = {
                command = { "nixpkgs-fmt" },
            },
        },
    },

}
