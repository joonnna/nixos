{ config, pkgs, ... }:


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
    ];
  };

  xdg.configFile.nvim = {
    source = ./config;
    recursive = true;
  };
}
