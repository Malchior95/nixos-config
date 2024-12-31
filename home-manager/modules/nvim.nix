{ pkgs, ... }: {
  programs.neovim = {
    enable = true;
    extraPackages = with pkgs; [
      lua-language-server
      nixd
      vimPlugins.nvim-treesitter-parsers.hyprlang
      vimPlugins.nvchad
      vimPlugins.nvchad-ui
      vimPlugins.nvim-treesitter
      vimPlugins.base46
      vimPlugins.nvim-web-devicons
      vimPlugins.indent-blankline-nvim
      vimPlugins.which-key-nvim
      vimPlugins.nvim-tree-lua
      vimPlugins.conform-nvim
      vimPlugins.gitsigns-nvim
      vimPlugins.nvim-cmp
      vimPlugins.nvim-autopairs
      vimPlugins.telescope-nvim
      vimPlugins.nvim-lspconfig
      vimPlugins.rustaceanvim
      vimPlugins.nvim-dap
      vimPlugins.nvim-dap-ui
    ];
    plugins = with pkgs.vimPlugins; [
      rustaceanvim
    ];
  };

  xdg.configFile.nvim = {
    recursive = true;
    source = ./nvim.nix.d;
  };

  home.packages = with pkgs; [
    rustc cargo rust-analyzer lldb
  ];
}
