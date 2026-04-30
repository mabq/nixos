{
  config,
  pkgs,
  user,
  repoPath,
  userProfilePath,
  ...
}: let
  mkSym = config.lib.file.mkOutOfStoreSymlink;
  configPath = "${userProfilePath}/config";
in {
  home = {
    file = {
      # export STARSHIP_CONFIG=${NIXOS_USERPROFILEPATH}/config/starship/starship.toml
      ".zshenv".source = ./config/zsh/.zshenv;
      ".config/starship.toml".source = ./config/starship/starship.toml
      ".config/tmux/tmux.conf".source = ./config/tmux/tmux.conf;
      # ".config/tmux/tmux.conf".source = mkSym "${configPath}/tmux/tmux.conf";
    };
    homeDirectory = "/home/${user}"; # TODO: check if needed
    packages = with pkgs; [
      # dnsutils # Domain name server - provides the `dig` command
      # ngrep # Network packet analyzer - use `sudo ngrep port <port>` to check if a port is being used
      age # Modern encryption tool with small explicit keys
      atuin # Replacement for a shell history
      bat # Cat clone with syntax highlighting and Git integration
      btop # Monitor of resources
      caligula # User-friendly, lightweight TUI for disk imaging
      exfat # Free exFAT file system implementation
      eza # Modern, maintained replacement for ls
      fd # Simple, fast and user-friendly alternative to find
      ffmpeg # Complete, cross-platform solution to record, convert and stream audio and video
      fzf # Command-line fuzzy finder
      imagemagick # Software suite to create, edit, compose, or convert bitmap images
      iperf # Tool to measure IP bandwidth using UDP or TCP
      ncdu # Disk usage analyzer with an ncurses interface
      neovim # Vim text editor fork
      nix-tree # Interactively browse a Nix store paths dependencies
      opencode # AI coding agent built for the terminal
      parted # Create, destroy, resize, check, and copy partitions
      pciutils # Provides the `lspci` command
      ripgrep # Utility that combines the usability of The Silver Searcher with the raw speed of grep
      starship # Customizable prompt for any shell
      tldr # Simplified and community-driven man pages
      tmux # Terminal multiplexer
      wget # Tool for retrieving files using HTTP, HTTPS, and FTP
      yazi # Blazing fast terminal file manager written in Rust, based on async I/O
      zoxide # Fast cd command that learns your habits
      zsh-autosuggestions # Fish shell autosuggestions for Zsh
      zsh-history-substring-search # Fish shell history-substring-search for Zsh
      zsh-syntax-highlighting # Fish shell like syntax highlighting for Zsh
    ];
    # You can update home Manager without changing this value. See
    # the home Manager release notes for a list of state version
    # changes in each release.
    stateVersion = "25.11";
    username = user; # TODO: check if needed
  };

  xdg = {
    enable = true;
    # Manage xdg directories, e.g.  ~/.config, ~/.local/share, etc.
    userDirs = {
      enable = true;
      setSessionVariables = true; # Create XDG variables automatically.
      createDirectories = true; # Automatically create ~/Downloads, etc.
      extraConfig = {
        SCREENSHOTS = "${config.home.homeDirectory}/Pictures/Screenshots";
      };
    };

    # -- Default apps
    # Declarative way of configuring `~/.config/mimeapps.list`. Changes
    # instroduced with the imperative command `xdg-mime default ...` will be
    # overriden on next reboot.
    #
    # To setup a default app, first check the MIME type of the file with
    # `xdg-mime query filetype <file>`, then check the available `.desktop`
    # files in directories included in $XDG_DATA_DIRS. Finally, link a MIME
    # type to a .desktop file here.
    mimeApps = {
      enable = true;
      defaultApplications = {
        "text/html" = "brave-browser.desktop";
        "application/pdf" = "brave-browser.desktop";
        "image/png" = "imv.desktop";
      };
    };
    desktopEntries = {
      # my-custom-app = {
      #   name = "My Custom App";
      #   genericName = "Text Editor";
      #   exec = "my-script %U";
      #   terminal = false;
      #   categories = [ "Application" "Development" ];
      #   icon = "accessories-text-editor";
      # };
    };
  };
}
