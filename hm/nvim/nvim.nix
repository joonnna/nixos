{ config, pkgs, lib, ... }:

let
  # installs a vim plugin from git with a given tag / branch
  pluginGit = ref: repo: pkgs.vimUtils.buildVimPluginFrom2Nix {
    pname = "${lib.strings.sanitizeDerivationName repo}";
    version = ref;
    src = builtins.fetchGit {
      url = "https://github.com/${repo}.git";
      ref = ref;
      rev = "624001be4550ab8c3657091a16c3a0ab31efc1fa";
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
      vim-commentary
      vim-surround
      vim-eunuch
      vim-repeat
      fzf-lua
      vim-rooter
      vim-highlightedyank
      lualine-nvim
      tokyonight-nvim

      vim-nix
      vim-fish
      csv-vim

      cmp_luasnip
      nvim-cmp
      cmp-nvim-lsp
      cmp-nvim-lsp-signature-help

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
            (raw_string_literal) @sql
        )
        (#offset! @sql 0 3 0 -2)
    )

    (macro_invocation
        macro: (identifier) @_macro (#any-of? @_macro "fetch_optional" "fetch_all" "insert" "execute" "fetch_one")
        (token_tree
            (raw_string_literal) @sql
        )
        (#offset! @sql 0 3 0 -2)
    )

    (call_expression
        (field_expression
            field: (field_identifier) @_field (#any-of? @_field "query" "execute")
        )
        (arguments
            (raw_string_literal) @sql
        )
        (#offset! @sql 0 3 0 -2)
    )
  '';
}
