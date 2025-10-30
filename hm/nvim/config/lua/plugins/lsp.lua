local cmp = require 'cmp'
local opts = { noremap = true, silent = true }


local cmp_select = { behavior = cmp.SelectBehavior.Select }


local on_attach = function(client, bufnr)
    if client.server_capabilities ~= nil then
        client.server_capabilities.semanticTokensProvider = nil
    end
end

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
        ['ESC'] = cmp.mapping.abort(),
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

vim.lsp.config('rust-analyzer', {
    capabilities = capabilities,
    on_attach = on_attach,
    cargo = {
        allFeatures = true,
        allTargets = true,
        extraEnv = {
            CARGO_TARGET_DIR = '/home/jon/workspace/rust-analyzer-target'
        },
    },
    check = {
        command = "clippy",
        allTargets = true,
        allFeatures = true,
        extraArgs = { "--tests" }
    }
})


-- When adding new lsps add them here
vim.lsp.enable({ 'terraformls', 'nil_ls', 'taplo', 'lua_ls', 'pyright', 'bashls', 'dockerls', 'yamlls', 'denols',
    'nushell', 'rust-analyzer' })

vim.lsp.config('lua_ls', {
    capabilities = capabilities,
    on_attach = on_attach,
})

-- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#yamlls
vim.lsp.config('yamlls', {
    capabilities = capabilities,
    on_attach = on_attach,
    settings = {
        yaml = {
            trace = {
                server = "verbose"
            },
            schemas = {
                ["https://json.schemastore.org/github-workflow.json"] = "/.github/workflows/*",
                -- Re-enable if we ever start working with kubernetes again
                -- kubernetes = "/*.yaml",
            },
            schemaDownload = { enable = true },
            validate = true
        },
    }
})

-- https://github.com/neovim/nvim-lspconfig/blob/master/doc/server_configurations.md#dockerls
vim.lsp.config('dockerls', {
    capabilities = capabilities,
    on_attach = on_attach,
})

vim.lsp.config('denols', {
    capabilities = capabilities,
    on_attach = on_attach,
    filetypes = { "javascript", "javascriptreact", "javascript.jsx", "typescript",
        "typescriptreact", "typescript.tsx", "markdown", "json" }
})

-- https://github.com/mads-hartmann/bash-language-server
vim.lsp.config('bashls', {
    capabilities = capabilities,
    on_attach = on_attach,
})

vim.lsp.config('taplo', {
    capabilities = capabilities,
})

vim.lsp.config('terraformls', {
    capabilities = capabilities,
    on_attach = on_attach,
})

vim.lsp.config('pyright', {
    capabilities = capabilities,
})

vim.lsp.config('nil_ls', {
    capabilities = capabilities,
    on_attach = on_attach,
    autostart = true,
    settings = {
        ['nil'] = {
            formatting = {
                command = { "nixpkgs-fmt" },
            },
        },
    },
})

vim.lsp.config('nushell', {
    capabilities = capabilities
})
