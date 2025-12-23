{
  config,
  pkgs,
  globals,
  ...
}:

{
  imports = [
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
  ];

  nixpkgs.config.allowUnfree = true;

  # Bootloader
  boot.loader = {
    systemd-boot.enable = true;
  };
  boot.kernelPackages = pkgs.linuxPackages;

  networking = {
    hostName = globals.HostName;
    networkmanager.enable = true;
    hosts = {
      # "192.168.18.33" = [ "raspi.casa.local" ];
      # "10.129.182.29" = [
       # "blog.inlanefreight.local"
       # "blog-dev.inlanefreight.local"
     # ];
    };
  };
  time.timeZone = "America/Chicago";
  i18n.defaultLocale = "en_US.UTF-8";

  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  users.users.${globals.UserName} = {
    isNormalUser = true;
    description = "Main User";
    extraGroups = [
      "wheel"
      "networkmanager"
      "wireshark"
      "docker"
    ];
    packages = with pkgs; [
      chromium
      google-chrome
    ];
  };

  environment.systemPackages = with pkgs; [
    ffmpeg
    jq
		ripgrep
		fzf
    fastfetch
    btop
    starship
    waybar-mpris
    playerctl
    waypaper
    waybar
    swaylock-effects
    swww
    nvidia-vaapi-driver
    nvidia-modprobe
    swaynotificationcenter
    neovim
    wget
    davinci-resolve
    wl-clipboard-rs
    git
    glib
    steam-run
    curl
    wlogout
    discord
    obs-studio
    spotify
    # lsd
    bat
    tmux
    fzf
    lazygit
    lazydocker
    wofi
    ghostty
    vscode
    adw-gtk3
    papirus-icon-theme
    nh
    nautilus
    gnumake
    go
    gopls
    #musl
    gcc
    #ly
    fastfetch
    btop
    steam
    pavucontrol
    # bitwarden-desktop
    docker
    docker-compose
    xdg-desktop-portal-wlr
    polkit
    nixfmt-rfc-style
    obsidian
    nmap
    openvpn
    #hashcat
    #burpsuite
    #caido
    wireshark
    #wordlists
    #rockyou
    #seclists
    #metasploit
    #gobuster
    #ffuf
    #sqlmap
    #john
    #thc-hydra
    qbittorrent
    stow
    yazi
        wezterm
        # TODO: how to replace this. Need for stylua to install...
        unzip
        #blueman
protonvpn-gui
    #grub2
    xwayland
    xwayland-satellite
    nodejs_24
  ];

  hardware = {
    graphics.enable = true;
    nvidia = {
      modesetting.enable = true;
      open = false;
    };
    bluetooth = {
      enable = true;
      settings = {
        General = {
          Enable = "Source,Sink,Media,Socket";
          AutoEnable = true;
          ControllerMode = "bredr";
          UserspaceHID = true;
          Experimental = true;
        };
        Input = {
          ClassicBondedOnly = false;
        };
      };
    };
  };

  fileSystems."/home/jh/games" = { 
    device = "/dev/disk/by-uuid/35b98e1d-889b-46aa-87a3-818be0a6a7dc";
    fsType = "ext4";
  };
  services.xserver.videoDrivers = [ "nvidia" ];

  xdg.portal.wlr.enable = true;
  fonts = {
    fontconfig.enable = true;
    packages = with pkgs; [
      nerd-fonts.jetbrains-mono
    ];
  };
  services = {
    displayManager.enable = true;
    displayManager.ly.enable = true;
    blueman.enable = true;
    # services.openssh.enable = true;
  };
  services.pipewire = {
    enable = true;
  };
  programs = {
    nix-ld.enable = true;
    niri.enable = true;
    xwayland.enable = true;
    wireshark.enable = true;

    _1password.enable = true;
    _1password-gui = {
      enable = true;
      polkitPolicyOwners = [globals.UserName];
    };

    steam = {
      enable = true;
      remotePlay.openFirewall = true;
      dedicatedServer.openFirewall = true;
    };
    gamemode.enable = true;
  };
  security.polkit.enable = true;
  virtualisation.docker.enable = true;

  environment.variables = {
    LD_LIBRARY_PATH = "/run/opengl-driver/lib";
    ELECTRON_OZONE_PLATFORM_HINT = "wayland";
    OZONE_PLATFORM = "wayland";
    GDK_BACKEND = "wayland";
  };

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # networking.firewall.enable = false;
  system.stateVersion = "25.11";

}
