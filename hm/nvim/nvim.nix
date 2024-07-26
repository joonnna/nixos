{ pkgs, lib, ... }:

let
  # installs a vim plugin from git with a given tag / branch
  pluginGit = ref: repo: pkgs.vimUtils.buildVimPlugin {
    pname = "${lib.strings.sanitizeDerivationName repo}";
    version = ref;
    src = builtins.fetchGit {
      url = "https://github.com/${repo}.git";
      ref = ref;
      rev = "793e90b42671e510057d6a1f4cd1d514fcacd8be";
    };
  };
  # always installs latest version
  plugin = pluginGit "HEAD";
in
{
  programs.neovim = {
    enable = true;
    plugins = with pkgs.vimPlugins; [
      nvim-treesitter.withAllGrammars
      nvim-treesitter-textobjects

      vim-commentary
      vim-eunuch
      vim-repeat
      fzf-lua
      vim-rooter
      vim-highlightedyank
      lualine-nvim
      tokyonight-nvim

      playground

      vim-nix
      vim-fish
      csv-vim
      flash-nvim
      nvim-surround
      lir-nvim

      # nvim-web-devicons
      # nvim-colorizer-lua

      cmp_luasnip
      luasnip
      nvim-cmp
      cmp-nvim-lsp
      cmp-nvim-lsp-signature-help
      cmp-path
      cmp-buffer

      nvim-lspconfig
      lualine-lsp-progress

      plenary-nvim
      (plugin "seblj/nvim-formatter")
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
