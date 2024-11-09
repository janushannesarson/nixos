{ inputs, config, pkgs, username, ... }:
let
  homeDirectory = "/home/${username}";
  dotfiles = config.lib.file.mkOutOfStoreSymlink "${homeDirectory}/repos/dotfiles";
in {
  # Make home-manager manage itself
  programs.home-manager.enable = true;

  home = { inherit username homeDirectory; };

  home.packages = with pkgs; [
    pavucontrol # Audio control gui

    # Screenshot
    swappy
    grim
    slurp

    discord
    vesktop # Third party Discord client
  ];

  ################
  ### Programs ###
  ################

  # Terminal Emulator
  programs.kitty.enable = true;
  programs.fish = {
    enable = true;
    interactiveShellInit = ''
      set fish_greeting # Disable greeting
      bind \cf ~/.local/bin/zellijsessionizer.sh 
    '';
    functions.fish_prompt = {
      body = ''
        set -l nix_shell_info (
          if test -n "$IN_NIX_SHELL"
          echo -n "(nix-shell)"
          end
        )
        # echo -n -s "$nix_shell_info ~>"
        printf '%s@%s %s%s%s%s> ' $USER $hostname (set_color $fish_color_cwd) (prompt_pwd) (set_color normal) "$nix_shell_info"
      '';
    };
  };
  programs.fzf = {
    enable = true;
    enableFishIntegration = true;
  };

  # Browser
  programs.firefox.enable = true;

  programs.direnv = {
    enable = true;
    # enableFishIntegration = true; true by default
    nix-direnv.enable = true;
  };

  # Text Editor
  programs.neovim = {
    enable = true;
    defaultEditor = true;

    extraPackages = with pkgs; [
      # Runtime dependendies
      ripgrep
      gnumake
      gcc
      luajit

      # Language servers
      lua-language-server
      nil
      nixd

      # Formatters
      nixpkgs-fmt
      stylua
    ];

  };

  # Git
  programs.git = {
    enable = true;
    userName = "janushannesarson";
    userEmail = "janushannesarson@gmail.com";
  };

  # Application Launcher
  programs.rofi = {
    enable = true;
    package = pkgs.rofi-wayland;
    extraConfig = {
      modi = "drun,run,filebrowser,window";
      show-icons = true;
      display-drun = "APPS";
      display-run = "RUN";
      display-filebrowser = "FILES";
      display-window = "WINDOW";
      drun-display-format = "{name}";
      window-format = "{w} · {c} · {t}";
    };
    theme = let
      inherit (config.lib.formats.rasi) mkLiteral;
    in {
      "*" = {
        font = "JetBrains Mono Nerd Font 10";
        background = mkLiteral "#180F39";
        background-alt = mkLiteral "#32197D";
        foreground = mkLiteral "#FFFFFF";
        selected = mkLiteral "#FF00F1";
        active = mkLiteral "#9878FF";
        urgent = mkLiteral "#7D0075";
      };

      window = {
        transparency = "real";
        location = mkLiteral "center";
        anchor = mkLiteral "center";
        fullscreen = false;
        width = mkLiteral "1000px";
        x-offset = mkLiteral "0px";
        y-offset = mkLiteral "0px";
        enabled = true;
        border-radius = mkLiteral "15px";
        cursor = "default";
        background-color = mkLiteral "@background";
      };

      mainbox = {
        enabled = true;
        spacing = mkLiteral "0px";
        background-color = mkLiteral "transparent";
        orientation = mkLiteral "horizontal";
        children = [ "imagebox" "listbox" ];
      };

      imagebox = {
        padding = mkLiteral "20px";
        background-color = mkLiteral "transparent";
        background-image = mkLiteral ("url(" + "\"${dotfiles}/images/b.png\"" + ", height)");
        orientation = mkLiteral "vertical";
        children = [ "inputbar" "dummy" "mode-switcher" ];
      };

      listbox = {
        spacing = mkLiteral "20px";
        padding = mkLiteral "20px";
        background-color = mkLiteral "transparent";
        orientation = mkLiteral "vertical";
        children = [ "message" "listview" ];
      };

      dummy = {
        background-color = mkLiteral "transparent";
      };

      inputbar = {
        enabled = true;
        spacing = mkLiteral "10px";
        padding = mkLiteral "15px";
        border-radius = mkLiteral "10px";
        background-color = mkLiteral "@background-alt";
        text-color = mkLiteral "@foreground";
        children = [ "textbox-prompt-colon" "entry" ];
      };

      textbox-prompt-colon = {
        enabled = true;
        expand = false;
        str = "";
        background-color = mkLiteral "inherit";
        text-color = mkLiteral "inherit";
      };

      entry = {
        enabled = true;
        background-color = mkLiteral "inherit";
        text-color = mkLiteral "inherit";
        cursor = mkLiteral "text";
        placeholder = "Search";
        placeholder-color = mkLiteral "inherit";
      };

      mode-switcher = {
        enabled = true;
        spacing = mkLiteral "20px";
        background-color = mkLiteral "transparent";
        text-color = mkLiteral "@foreground";
      };

      button = {
        padding = mkLiteral "15px";
        border-radius = mkLiteral "10px";
        background-color = mkLiteral "@background-alt";
        text-color = mkLiteral "inherit";
        cursor = mkLiteral "pointer";
      };

      "button selected" = {
        background-color = mkLiteral "@selected";
        text-color = mkLiteral "@foreground";
      };

      listview = {
        enabled = true;
        columns = 1;
        lines = 8;
        cycle = true;
        dynamic = true;
        scrollbar = false;
        layout = mkLiteral "vertical";
        reverse = false;
        fixed-height = true;
        fixed-columns = true;
        spacing = mkLiteral "10px";
        background-color = mkLiteral "transparent";
        text-color = mkLiteral "@foreground";
        cursor = "default";
      };

      element = {
        enabled = true;
        spacing = mkLiteral "15px";
        padding = mkLiteral "8px";
        border-radius = mkLiteral "10px";
        background-color = mkLiteral "transparent";
        text-color = mkLiteral "@foreground";
        cursor = mkLiteral "pointer";
      };
      "element normal.normal" = {
        background-color = mkLiteral "inherit";
        text-color = mkLiteral "inherit";
      };
      "element normal.urgent" = {
        background-color = mkLiteral "@urgent";
        text-color = mkLiteral "@foreground";
      };
      "element normal.active" = {
        background-color = mkLiteral "@active";
        text-color = mkLiteral "@foreground";
      };
      "element selected.normal" = {
        background-color = mkLiteral "@selected";
        text-color = mkLiteral "@foreground";
      };
      "element selected.urgent" = {
        background-color = mkLiteral "@urgent";
        text-color = mkLiteral "@foreground";
      };
      "element selected.active" = {
        background-color = mkLiteral "@urgent";
        text-color = mkLiteral "@foreground";
      };
      element-icon = {
        background-color = mkLiteral "transparent";
        text-color = mkLiteral "inherit";
        size = mkLiteral "32px";
        cursor = mkLiteral "inherit";
      };
      element-text = {
        background-color = mkLiteral "transparent";
        text-color = mkLiteral "inherit";
        cursor = mkLiteral "inherit";
        vertical-align = mkLiteral "0.5";
        horizontal-align = mkLiteral "0.0";
      };

      message = {
        background-color = mkLiteral "transparent";
      };

      textbox = {
        padding = mkLiteral "15px";
        border-radius = mkLiteral "10px";
        background-color = mkLiteral "@background-alt";
        text-color = mkLiteral "@foreground";
        vertical-align = mkLiteral "0.5";
        horizontal-align = mkLiteral "0.0";
      };

      error-message = {
        padding = mkLiteral "15px";
        border-radius = mkLiteral "20px";
        background-color = mkLiteral "@background";
        text-color = mkLiteral "@foreground";
      };
    };
  };

  # Compositor
  wayland.windowManager.hyprland = {
  	package = inputs.hyprland.packages.${pkgs.system}.hyprland;  
  	enable = true;
	extraConfig = ''
	'';
  };

  # Out of store symlinks
  home.file.".local/bin".source = config.lib.file.mkOutOfStoreSymlink "/home/janus/repos/dotfiles/.local/bin/";
  xdg.configFile = {
    # "kitty".source = "${dotfiles}/.config/kitty";
    # "hypr".source = "${dotfiles}/.config/hypr";
    "zellij".source = "${dotfiles}/.config/zellij";
    "nvim".source = "${dotfiles}/.config/nvim";
    "Code/User".source = "${dotfiles}/.config/Code/User";
  };

  home.stateVersion = "23.11";
}
