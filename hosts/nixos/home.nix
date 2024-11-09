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
# #######################################################################################
# AUTOGENERATED HYPR CONFIG.
# PLEASE USE THE CONFIG PROVIDED IN THE GIT REPO /examples/hypr.conf AND EDIT IT,
# OR EDIT THIS ONE ACCORDING TO THE WIKI INSTRUCTIONS.
# #######################################################################################

# This is an example Hyprland config file.
# Refer to the wiki for more information.
# https://wiki.hyprland.org/Configuring/Configuring-Hyprland/

# Please note not all available settings / options are set here.
# For a full list, see the wiki

# You can split this configuration into multiple files
# Create your files separately and then link them to this file like this:
# source = ~/.config/hypr/myColors.conf


################
### MONITORS ###
################

# See https://wiki.hyprland.org/Configuring/Monitors/
monitor=eDP-1,1920x1080@60,auto,1
# monitor=DP-4,5120x1440@60,0x0,1,


##################
### MY PROGRAMS ###
###################

# See https://wiki.hyprland.org/Configuring/Keywords/

# Set programs that you use
$terminal = kitty
$fileManager = thunar
$menu = rofi -show run


#################
### AUTOSTART ###
#################

# Autostart necessary processes (like notifications daemons, status bars, etc.)
# Or execute your favorite apps at launch like this:

# exec-once = $terminal
# exec-once = nm-applet &
exec-once = waybar & hyprpaper & nm-applet & udiskie
#& hyprpaper & firefox

#############################
### ENVIRONMENT VARIABLES ###
#############################

# See https://wiki.hyprland.org/Configuring/Environment-variables/

env = XCURSOR_SIZE,24
env = HYPRCURSOR_SIZE,24


#####################
### LOOK AND FEEL ###
#####################

# Refer to https://wiki.hyprland.org/Configuring/Variables/

# https://wiki.hyprland.org/Configuring/Variables/#general
general { 
    gaps_in = 0 
    gaps_out = 0

    border_size = 1

    # https://wiki.hyprland.org/Configuring/Variables/#variable-types for info about colors
    col.active_border = rgba(33ccffee) rgba(00ff99ee) 45deg
    col.inactive_border = rgba(595959aa)

    # Set to true enable resizing windows by clicking and dragging on borders and gaps
    resize_on_border = false 

    # Please see https://wiki.hyprland.org/Configuring/Tearing/ before you turn this on
    allow_tearing = false

    layout = master
}

# https://wiki.hyprland.org/Configuring/Variables/#decoration
decoration {
    # rounding = 10

    # Change transparency of focused and unfocused windows
    active_opacity = 1.0
    inactive_opacity = 1.0

    drop_shadow = true
    shadow_range = 4
    shadow_render_power = 3
    col.shadow = rgba(1a1a1aee)

    # https://wiki.hyprland.org/Configuring/Variables/#blur
    blur {
        enabled = true
        size = 3
        passes = 1
        
        vibrancy = 0.1696
    }
}

# https://wiki.hyprland.org/Configuring/Variables/#animations
animations {
    enabled = true

    # Default animations, see https://wiki.hyprland.org/Configuring/Animations/ for more

    bezier = myBezier, 0.05, 0.9, 0.1, 1.05

    animation = windows, 1, 7, myBezier
    animation = windowsOut, 1, 7, default, popin 80%
    animation = border, 1, 10, default
    animation = borderangle, 1, 8, default
    animation = fade, 1, 7, default
    animation = workspaces, 0, 6, default
}

# See https://wiki.hyprland.org/Configuring/Dwindle-Layout/ for more
dwindle {
    pseudotile = true # Master switch for pseudotiling. Enabling is bound to mainMod + P in the keybinds section below
    preserve_split = true # You probably want this
}

# See https://wiki.hyprland.org/Configuring/Master-Layout/ for more
master {
    mfact = 0.40
    new_status = slave
    orientation = center
    always_center_master = true
}

# https://wiki.hyprland.org/Configuring/Variables/#misc
misc { 
    force_default_wallpaper = -1 # Set to 0 or 1 to disable the anime mascot wallpapers
    disable_hyprland_logo = false # If true disables the random hyprland logo / anime girl background. :(
}


#############
### INPUT ###
#############

# https://wiki.hyprland.org/Configuring/Variables/#input
input {
    kb_layout = us
    kb_variant =
    kb_model =
    kb_options =
    kb_rules =

    follow_mouse = 1

    sensitivity = 0 # -1.0 - 1.0, 0 means no modification.

    touchpad {
        natural_scroll = false
    }
}

# https://wiki.hyprland.org/Configuring/Variables/#gestures
gestures {
    workspace_swipe = false
}

# Example per-device config
# See https://wiki.hyprland.org/Configuring/Keywords/#per-device-input-configs for more
device {
    name = epic-mouse-v1
    sensitivity = -0.5
}


####################
### KEYBINDINGSS ###
####################

# See https://wiki.hyprland.org/Configuring/Keywords/
$mainMod = SUPER # Sets "Windows" key as main modifier

# Example binds, see https://wiki.hyprland.org/Configuring/Binds/ for more
bind = $mainMod, Return, exec, $terminal
bind = $mainMod, Q, killactive,
bind = $mainMod, M, exit,
bind = $mainMod, E, exec, $fileManager
bind = $mainMod, V, togglefloating,
bind = $mainMod, R, exec, $menu
bind = $mainMod, P, pseudo, # dwindle
bind = $mainMod, J, togglesplit, # dwindle

# Move focus with mainMod + arrow keys
bind = $mainMod, h, movefocus, l
bind = $mainMod, l, movefocus, r
bind = $mainMod, k, movefocus, u
bind = $mainMod, j, movefocus, d

# Switch workspaces with mainMod + [0-9]
bind = $mainMod, 1, workspace, 1
bind = $mainMod, 2, workspace, 2
bind = $mainMod, 3, workspace, 3
bind = $mainMod, 4, workspace, 4
bind = $mainMod, 5, workspace, 5
bind = $mainMod, 6, workspace, 6
bind = $mainMod, 7, workspace, 7
bind = $mainMod, 8, workspace, 8
bind = $mainMod, 9, workspace, 9
bind = $mainMod, 0, workspace, 10

# Move active window to a workspace with mainMod + SHIFT + [0-9]
bind = $mainMod SHIFT, 1, movetoworkspace, 1
bind = $mainMod SHIFT, 2, movetoworkspace, 2
bind = $mainMod SHIFT, 3, movetoworkspace, 3
bind = $mainMod SHIFT, 4, movetoworkspace, 4
bind = $mainMod SHIFT, 5, movetoworkspace, 5
bind = $mainMod SHIFT, 6, movetoworkspace, 6
bind = $mainMod SHIFT, 7, movetoworkspace, 7
bind = $mainMod SHIFT, 8, movetoworkspace, 8
bind = $mainMod SHIFT, 9, movetoworkspace, 9
bind = $mainMod SHIFT, 0, movetoworkspace, 10

# Example special workspace (scratchpad)
bind = $mainMod, S, togglespecialworkspace, magic
bind = $mainMod SHIFT, S, movetoworkspace, special:magic

# Scroll through existing workspaces with mainMod + scroll
bind = $mainMod, mouse_down, workspace, e+1
bind = $mainMod, mouse_up, workspace, e-1

# Move/resize windows with mainMod + LMB/RMB and dragging
bindm = $mainMod, mouse:272, movewindow
bindm = $mainMod, mouse:273, resizewindow


# Move windows with hjkl
bind = $mainMod shift, H, movewindow, l
bind = $mainMod shift, L, movewindow, r
bind = $mainMod shift, K, movewindow, u
bind = $mainMod shift, J, movewindow, d


##############################
### WINDOWS AND WORKSPACES ###
##############################

# See https://wiki.hyprland.org/Configuring/Window-Rules/ for more
# See https://wiki.hyprland.org/Configuring/Workspace-Rules/ for workspace rules

# Example windowrule v1
# windowrule = float, ^(kitty)$

# Example windowrule v2
# windowrulev2 = float,class:^(kitty)$,title:^(kitty)$

windowrulev2 = suppressevent maximize, class:.* # You'll probably like this.
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
