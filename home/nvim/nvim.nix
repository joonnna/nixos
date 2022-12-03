{ config, pkgs, ... }:


# let
#   rainbow_csv = pkgs.vimUtils.buildVimPlugin {
#     name = "rainbow_csv";
#     src = pkgs.fetchFromGitHub {
#       owner = "mechatroner";
#       repo = "rainbow_csv";
#       rev = "959322371c78ff9d1dd78b954a725d25da2cdd93";
#       sha256 = "007zbym9q441dcqnfvdycvi4qd91lj2cllirds1w2928w8zvgnb4x";
#     };
#   };
#   vim-bicep = pkgs.vimUtils.buildVimPlugin {
#     name = "vim-bicep";
#     src = pkgs.fetchFromGitHub {
#       owner = "carlsmedstad";
#       repo = "vim-bicep";
#       rev = "master";
#     };
#   };
# in
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
      # vim-bicep
      # rainbow_csv

      cmp_luasnip
      nvim-cmp
      cmp-buffer
      cmp-nvim-lsp
      cmp-nvim-lsp-signature-help

      nvim-lspconfig
      lualine-lsp-progress
    ];
  };

  xdg.configFile.nvim = {
    source = ./config;
    recursive = true;
  };
}
