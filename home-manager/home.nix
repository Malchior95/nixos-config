{ pkgs, config, user, homeStateVersion, ... }: {

  home = {
    username = user;
    homeDirectory = "/home/${user}";
    stateVersion = homeStateVersion;

    packages = with pkgs; [ neovim helix tmux bat eza nixfmt git gh ];
  };

  programs.bash = {
    enable = true;
    shellAliases = {
      cat = "bat --paging=never";
      ls = "eza";
    };
    initExtra = ''
      if command -v tmux &> /dev/null && [ -n "$PS1" ] && [[ ! "$TERM" =~ screen ]] && [[ ! "$TERM" =~ tmux ]] && [ -z "$TMUX" ]; then
        exec tmux
      fi

    '';
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

  # DO NOT SETUP GIT, OR GH WILL NOT BE ABLE TO LOGIN TO GITHUB
  programs.git = {
    enable = true;
    extraConfig = {
      user.name = "Malchior95";
      user.email = "malchior95@gmail.com";
    };
  };

  home.file.".config/nvim".source = ./dotfiles/nvim;
  home.file.".config/tmux".source = ./dotfiles/tmux;
}
