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
      nvim-treesitter.withAllGrammars
      nvim-treesitter-textobjects

      fzf-lua
      vim-rooter
      vim-highlightedyank

      # Lua version of Tpope surround + extra features
      nvim-surround

      # Enables lsp configuration
      nvim-lspconfig

      # Status bar
      lualine-nvim
      lualine-lsp-progress

      # Treesitter playground
      playground

      # Motion plugin
      flash-nvim

      # Syntax highlighting for nix
      vim-nix
      # Syntax highlighting for fish
      vim-fish

      # Filesystem management
      oil-nvim

      # Dependency of several plugins (atleast nvim-formatter)
      plenary-nvim

      # Dependency of lazydocker
      nui-nvim

      # Connects with browser plugin firenvim to enable nvim in text field in browser
      # Might need to run install nvim --headless "+call firenvim#install(0) | q"
      firenvim

      # Integrates with Cargo.toml files in rust projects
      crates-nvim
      # Adds additional rust lsp features
      rustaceanvim

      lazygit-nvim

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

      (pluginGit "seblj/nvim-formatter" "793e90b42671e510057d6a1f4cd1d514fcacd8be" "HEAD")
      (pluginGit "crnvl96/lazydocker.nvim" "f6b5af40085b151fdbe2d50c2670b8f8ed604006" "v1.4.0")
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
