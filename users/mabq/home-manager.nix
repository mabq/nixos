{
  config,
  pkgs,
  user,
  ...
}: {
  home = {
    file = {
      ".zshenv".text = ''
        ZDOTDIR="$HOME/.local/share/nixos-config/users/${user}/zsh"
      '';
      # ".config/starship.toml".source = ./starship/starship.toml;
    };
    homeDirectory = "/home/${user}";
    packages = with pkgs; [
      # age # Modern encryption tool with small explicit keys
      # caligula # User-friendly, lightweight TUI for disk imaging
      # dnsutils # Domain name server - provides the `dig` command
      # iperf # Tool to measure IP bandwidth using UDP or TCP
      # ngrep # Network packet analyzer - use `sudo ngrep port <port>` to check if a port is being used
      # pciutils # Provides the `lspci` command
      atuin # Replacement for a shell history
      bat # Cat clone with syntax highlighting and Git integration
      btop # Monitor of resources
      eza # Modern, maintained replacement for ls
      fd # Simple, fast and user-friendly alternative to find
      fzf # Command-line fuzzy finder
      ncdu # Disk usage analyzer with an ncurses interface
      neovim # Vim text editor fork
      nix-tree # Interactively browse a Nix store paths dependencies
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
    username = user;
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
