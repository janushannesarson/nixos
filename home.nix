{
  config,
  pkgs,
  unstablePkgs,
  ...
}:
let
  username = "janus";
  homeDirectory = "/home/${username}";
in
{
  nixpkgs.config.allowUnfree = true;
  # Make home-manager manage itself
  programs.home-manager.enable = true;

  home = {
    inherit username homeDirectory;
  };

  home.packages =
    (with pkgs; [
      lua-language-server
      nixd
      rust-analyzer
      vscode-langservers-extracted
    ])
    ++ (with unstablePkgs; [
      jetbrains.idea-ultimate
      jdk23
      maven

      nixfmt-rfc-style
    ]);

  home.shellAliases = {
    tm = "tmux new -As0";
  };

  programs.yazi.enable = true;

  # Terminal Emulator
  programs.kitty = {
    enable = true;
    shellIntegration.enableFishIntegration = true;
  };

  programs.bash = {
    enable = true;
    initExtra = ''
        if [[ $(${pkgs.procps}/bin/ps --no-header --pid=$PPID --format=comm) != "fish" && -z ''${BASH_EXECUTION_STRING} ]]
      	  then
      		  shopt -q login_shell && LOGIN_OPTION='--login' || LOGIN_OPTION=""
      		  exec ${pkgs.fish}/bin/fish $LOGIN_OPTION
      		  fi
      		  '';
  };

  programs.fish = {
    enable = true;
    interactiveShellInit = ''
      set fish_greeting # Disable greeting
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

  programs.tmux = {
    enable = true;
    plugins = [ pkgs.tmuxPlugins.pain-control ];
    extraConfig = ''
      set -s escape-time 0
      set -g base-index 1
      set -g pane-base-index 1
      setw -g mode-keys vi
      bind-key -r f run-shell "tmux neww ~/.local/bin/tmuxsessionizer.sh"
    '';
  };

  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
    # enableFishIntegration = true;# true by default
    enableBashIntegration = true;
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
    difftastic.enable = true;
  };

  programs.lazygit = {
    enable = true;
    settings = {
      promptToReturnFromSubprocess = false;
    };
  };

  # Out of store symlinks
  home.file.".local/bin".source =
    config.lib.file.mkOutOfStoreSymlink "/${homeDirectory}/repos/dotfiles/.local/bin/";
  home.file.".config/hypr".source =
    config.lib.file.mkOutOfStoreSymlink "/${homeDirectory}/repos/nixos/dotfiles/.config/hypr";
  home.file.".config/nvim".source =
    config.lib.file.mkOutOfStoreSymlink "/${homeDirectory}/repos/nixos/dotfiles/.config/nvim";

  home.stateVersion = "23.11";
}
