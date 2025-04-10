{ pkgs, lib, ... }:

let
  pluginGit = repo: rev: version: pkgs.vimUtils.buildVimPlugin {
    pname = "${lib.strings.sanitizeDerivationName repo}";
    version = version;
    src = builtins.fetchGit {
      url = "https://github.com/${repo}.git";
      rev = rev;
    };
  };
in
{
  programs.neovim = {
    enable = true;
    plugins = with pkgs.vimPlugins; [
      # Adding playground disables all nix installed parsers,
      # see https://github.com/NixOS/nixpkgs/issues/282927#issuecomment-2329559505 for details
      # Treesitter playground
      # playground
      nvim-treesitter.withAllGrammars
      nvim-treesitter-textobjects

      fzf-lua
      vim-rooter

      # Lua version of Tpope surround + extra features
      nvim-surround

      # Enables lsp configuration
      nvim-lspconfig

      # Lsp progress
      fidget-nvim

      # Motion plugin
      flash-nvim

      # Syntax highlighting for fish
      # TODO: use lsp https://github.com/ndonfris/fish-lsp
      vim-fish

      # Filesystem management
      oil-nvim

      # Dependency of several plugins (atleast nvim-formatter)
      plenary-nvim

      # Integrates with Cargo.toml files in rust projects
      # crates-nvim
      # Adds additional rust lsp features
      rustaceanvim

      # Search and replace across files
      nvim-spectre

      # Used when changing colors in colorscheme
      # nvim-colorizer-lua

      # Autocompletion stack
      cmp_luasnip
      luasnip
      nvim-cmp
      cmp-nvim-lsp
      cmp-nvim-lsp-signature-help
      cmp-path
      cmp-buffer

      # TODO: use nixpkgs version when its updated
      # (pluginGit "saecki/crates.nvim" "a63681f36d06cf733ccbd296481957fb1efa6d09" "HEAD")
      (pluginGit "seblj/nvim-formatter" "793e90b42671e510057d6a1f4cd1d514fcacd8be" "HEAD")
    ];
  };


  xdg.configFile.nvim = {
    source = ./config;
    recursive = true;
  };

  xdg.configFile."nvim/after/queries/sql/injections.scm".text = ''
    ; extends

    (field) @variable

    (parameter) @type

    (column) @variable
  '';

  xdg.configFile."nvim/after/queries/rust/injections.scm".text = ''
    ; extends

    (macro_invocation
        (scoped_identifier
            path: (identifier) @_path (#eq? @_path "sqlx")
            name: (identifier) @_name (#match? @_name "query")
        )
        (token_tree
            (raw_string_literal
                (string_content) @injection.content
            )
        )
        (#set! injection.language "sql")
    )
  '';
}
