{ config, pkgs, lib, ... }:

let
  # installs a vim plugin from git with a given tag / branch
  pluginGit = ref: repo: pkgs.vimUtils.buildVimPluginFrom2Nix {
    pname = "${lib.strings.sanitizeDerivationName repo}";
    version = ref;
    src = builtins.fetchGit {
      url = "https://github.com/${repo}.git";
      ref = ref;
      rev = "831a2b3a3cf6b7a0f365625831a23747241e7149";
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

      cmp_luasnip
      nvim-cmp
      cmp-buffer
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

  xdg.configFile."nvim/after/queries/rust/injections.scm".text = ''
    ; extends

    (macro_invocation
        (scoped_identifier
            path: (identifier) @_path (#not-eq? @_path "sqlx")
            name: (identifier) @_name (#not-match? @_name "query")
        )
        (token_tree) @rust
    )

    (macro_invocation
        macro: (identifier) @_macro (#not-any-of? @_macro "fetch_optional" "fetch_all" "insert" "execute")
        (token_tree) @rust
    )

    (macro_invocation
        (token_tree
          (identifier) @rust
        )
    )

    (macro_invocation
        (token_tree
          (token_tree) @rust
        )
    )

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
        macro: (identifier) @_macro (#any-of? @_macro "fetch_optional" "fetch_all" "insert" "execute")
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


    ;
    ; Default values from ~/.local/share/nvim/site/pack/packer/start/nvim-treesitter/queries/rust/injections.scm
    ;

    ; Replaced with the three `macro_invocation`'s at top of file
    ; (macro_invocation
    ;   (token_tree) @rust)

    (macro_definition
      (macro_rule
        left: (token_tree_pattern) @rust
        right: (token_tree) @rust))

    [
      (line_comment)
      (block_comment)
    ] @comment

    (
      (macro_invocation
        macro: ((identifier) @_html_def)
        (token_tree) @html)

        (#eq? @_html_def "html")
    )

    (call_expression
      function: (scoped_identifier
        path: (identifier) @_regex (#eq? @_regex "Regex")
        name: (identifier) @_new (#eq? @_new "new"))
      arguments: (arguments
        (raw_string_literal) @regex))

    (call_expression
      function: (scoped_identifier
        path: (scoped_identifier (identifier) @_regex (#eq? @_regex "Regex").)
        name: (identifier) @_new (#eq? @_new "new"))
      arguments: (arguments
        (raw_string_literal) @regex))
  '';
}
