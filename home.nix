{ config, pkgs, ... }:

{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "adibaron";
  home.homeDirectory = "/Users/adibaron";

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "24.05"; # Please read the comment before changing.

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = [
    # # Adds the 'hello' command to your environment. It prints a friendly
    # # "Hello, world!" when run.
    pkgs.zsh
    pkgs.lsd
    pkgs.bat
    pkgs.tmux
    pkgs.kubecolor
    pkgs.ripgrep
    pkgs.tree
    pkgs.xclip
    pkgs.starship
    pkgs.wezterm
    pkgs.git
    pkgs.nix-direnv
    pkgs.clj-kondo
    pkgs.arc-browser

    # # It is sometimes useful to fine-tune packages, for example, by applying
    # # overrides. You can do that directly here, just don't forget the
    # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
    # # fonts?
    # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })

    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')
  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    ".config/nvim".source = ./nvim-config;
    ".config/nvim".recursive = true;

    ".config/tmux".source = ./tmux-config;
    ".config/tmux".recursive = true;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. These will be explicitly sourced when using a
  # shell provided by Home Manager. If you don't want to manage your shell
  # through Home Manager then you have to manually source 'hm-session-vars.sh'
  # located at either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/adibaron/etc/profile.d/hm-session-vars.sh
  #
  home.sessionVariables = {
    # EDITOR = "emacs";
    NIXPKGS_ALLOW_UNFREE = 1;
  };

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autocd = true;
    syntaxHighlighting.enable = true;

    shellAliases = {
      ls = "lsd";
      la = "ls -la";
      ll = "ls -l";
      lt = "ls --tree";
      cat = "bat";
      v = "nvim";
      vi = "nvim";
      ".." = "cd ..";
      hme = "cd ~/.config/home-manager/ && nvim home.nix";
      hms = "home-manager switch";
    };
  };

  programs.starship = {
    enable = true;
    enableZshIntegration = true;

    settings = {
      add_newline = true;

      format = '' $username[](bg:#2a9d8f fg:#264653)$directory[](fg:#2a9d8f bg:#e9c46a)$git_branch$git_status[](fg:#e9c46a bg:#f4a261)$rust$scala$java$python$lua[](fg:#f4a261 bg:#e76f51)[ ](fg:#e76f51)$fill [](#e76f51)$time[](bg:#e76f51 fg:#f4a261)[](bg:#f4a261 fg:#e9c46a)[](bg:#e9c46a fg:#2a9d8f)$memory_usage[](bg:#2a9d8f fg:#264653)$nix_shell$line_break$character'';

      nix_shell = {
        disabled = false;
        impure_msg = "⍻";
        pure_msg = "⎷";
        symbol = "";
        style = "bg:#264653 fg:#ffffff";
        format = "[ nix $state ]($style)";
      };

      memory_usage = {
        disabled = false;
        threshold = 0;
        format = "[ $ram( | $swap) ]($style)";
        style = "bg:#2a9d8f fg:#ffffff";
      };

      java = {
        disabled = false;
        style = "fg:#ffffff bg:#f4a261";
        format = "[ JVM $version ]($style)";
      };

      python = {
        disabled = false;
        style = "fg:#ffffff bg:#f4a261";
        format = "[ Python $version $virtualenv]($style)";
      };

      lua = {
        disabled = false;
        style = "fg:#ffffff bg:#f4a261";
        format = "[ Lua $version ]($style)";
      };

      line_break = {
        disabled = false;
      };

      fill = {
        symbol = "-";
        style = "fg:#e9c46a";
      };

      character = {
        #success_symbol = "[➜](bold #e76f51)";
      };

      username = {
        show_always = true;
        style_user = "bg:#264653 fg:#ffffff";
        format = "[  $user ]($style)";
        disabled = false;
      };

      directory = {
        style = "bg:#2a9d8f fg:#ffffff";
        format = "[ $path ]($style)";
        truncation_length = 3;
        truncate_to_repo = false;
        truncation_symbol = ".../";
      };

      git_branch = {
        symbol = "";
        style = "bg:#e9c46a fg:#000000";
        format = "[ $symbol $branch ]($style)";
      };

      git_status = {
        style = "bg:#e9c46a fg:#000000";
        format = "[$all_status$ahead_behind ]($style)";
      };

      time = {
        disabled = false;
        style = "bg:#e76f51 fg:#ffffff";
        format = "[  $time ]($style)";
      };


    };
  };

  programs.wezterm = {
    enable = true;

    extraConfig = ''
      return {
        color_scheme = "tokyonight_storm",
        hide_tab_bar_if_only_one_tab = true,
        initial_rows = 57,
        initial_cols = 240,
      }
    '';
  };

  programs.neovim = {
    enable = true;

    #    extraLuaConfig = ''
    #  ${builtins.readFile ~/.config/home-manager/nvim/init.lua}
    #'';
  };

  programs.direnv = {
    enable = true;
    enableZshIntegration = true;
    nix-direnv.enable = true;
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

}
