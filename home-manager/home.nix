{ pkgs, config, user, homeStateVersion, ... }: {

  imports [
    ./modules
  ];
  
  home = {
    username = user;
    homeDirectory = "/home/${user}";
    stateVersion = homeStateVersion;

    packages = with pkgs; [  ];
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

  
}
