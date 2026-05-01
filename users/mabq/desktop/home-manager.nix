{
  config, # home-manager options, not NixOS options
  pkgs,
  user,
  profile,
  ...
}: let
  theme = "catppuccin"; # must match one of the directory names in the themes folder

  repoName = "nixos-config"; # 1
  repoPath = "/home/${user}/.local/share/${repoName}"; # 2
  themePath = "${repoPath}/themes/${theme}";
  profilePath = "${repoPath}/users/${user}/${profile}";
  configPath = "${profilePath}/config/";

  currentThemePath = "/home/${user}/.config/${repoName}/current/theme";

  symlinkToConfig = path: config.lib.file.mkOutOfStoreSymlink "${configPath}/${path}"; # 3
in {
  home = {
    file = {
      ".zshenv".text = ''
        # Be careful what you put in this file, it affects every zsh invocation (including scp, rsync, etc).
        setopt NO_GLOBAL_RCS # --- Ignore zsh global config files, except `/etc/zshenv` which is read before this file.
        ZDOTDIR="${profilePath}/config/zsh" # --- Source zsh config files directly from the repository, no need to export.
        export NIXOS_USERPROFILEPATH="${profilePath}" # --- Hard-coded into some files.
      '';
      ".config/btop/btop.conf" = {
        source = symlinkToConfig "btop.conf";
        force = true;
      };
      ".config/btop/themes/current.theme".source = "${currentThemePath}/btop.theme"; # the link never changes again
      ".config/starship.toml".source = symlinkToConfig "starship.toml";
      ".config/tmux/tmux.conf".source = symlinkToConfig "tmux.conf";
      ".config/${repoName}/current/theme".source = config.lib.file.mkOutOfStoreSymlink "${repoPath}/themes/${theme}";
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
    username = user; # TODO: check if needed

    # This value determines the Home Manager release that your
    # configuration is compatible with. This helps avoid breakage
    # when a new Home Manager release introduces backwards
    # incompatible changes.
    # You can update Home Manager without changing this value. See
    # the Home Manager release notes for a list of state version
    # changes in each release.
    stateVersion = "25.11";
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
# 1. This name is used to refer to our configuration.
#    Change it to match the name of the upstream repositoty.
#
# 2. Symlinks require absolute paths! Cannot contain `$HOME` or `~`.
#    Change this if you ever decide to place the repository in another location.
#
# 3. This functions creates a symlink pointing to the given config file in the repository,
#    instead of creating an inmutable copy of the file in the Nix Store and point to it.
#    This way you can make edits to those files in the local machine and see those changes
#    inmediately, without needing to rebuild NixOS or even fetch the repository.
#    If you like the changes, commit and push. Otherwise just reset.

