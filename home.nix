{ pkgs, config, user, homeStateVersion, ... }: {

  home = {
    username = user;
    homeDirectory = "/home/${user}";
    stateVersion = homeStateVersion;

    packages = with pkgs; [ neovim helix tmux bat eza nixfmt ];
  };

  programs.bash = {
    enable = true;
    shellAliases = {
      cat = "bat";
      ls = "eza";
    };
  };

  programs.helix = {
    enable = true;
    settings = {
      theme = "gruvbox";
      editor.cursor-shape = {
        normal = "block";
        insert = "bar";
        select = "underline";
      };
    };
    languages.language = [{
      name = "nix";
      auto-format = true;
      formatter.command = "${pkgs.nixfmt}/bin/nixfmt";
    }];
  };

  programs.git = {
    extraConfig = {
      user.name = "Malchior95";
      user.email = "malchior95@gmail.com";
    };
  };

  # file.".bashrc".source = "./dotfiles/.bashrc";  
}
