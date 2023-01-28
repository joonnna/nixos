-- NIXOS workaround
-- Defines a RW directory for treesitter in the cache dir
-- See https://github.com/NixOS/nixpkgs/issues/189838
local parser_install_dir = vim.fn.stdpath("cache") .. "/treesitters"
vim.fn.mkdir(parser_install_dir, "p")
vim.opt.runtimepath:append(parser_install_dir)


require 'nvim-treesitter.configs'.setup {
    parser_install_dir = parser_install_dir,
    ensure_installed = { "rust", "lua", "yaml", "bash", "fish", "json", "sql", "toml", "markdown" },
    sync_install = false,
    auto_install = false,

    highlight = { enable = true },
}
