{
  config,
  pkgs,
  globals,
  inputs,
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
  boot.kernelModules = [
    "hid_playstation"
    "xpad"
  ];

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
  i18n.supportedLocales = [
    "en_US.UTF-8/UTF-8"
    "ko_KR.UTF-8/UTF-8"
    "ja_JP.UTF-8/UTF-8"
  ];
  # Enable IME
  # i18n.inputMethod = {
  #   enable = true;
  #   type = "kime";
  # kime.iconColor = "White";
  # fcitx5.addons = with pkgs; [
  #   fcitx5-mozc
  #   fcitx5-hangul
  #   fcitx5-gtk
  # ];
  # };
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
      "plugdev" # zsa moonlander udev
    ];
    packages = with pkgs; [
      # chromium
      google-chrome
    ];
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIMKmSb03l6MOhGnJzit57QfPMBlashhIfzVRk/KXx49U personal-mb"
    ];
  };

  environment.systemPackages = with pkgs; [
    inputs.awww.packages.${pkgs.stdenv.hostPlatform.system}.awww
    ffmpeg
    jq
    ripgrep
    fzf
    fd
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
    adw-gtk3
    papirus-icon-theme
    nh
    nautilus
    gnumake
    go
    gopls
    cargo
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
    xdg-desktop-portal-gtk
    xdg-desktop-portal-gnome
    xdg-desktop-portal
    polkit
    nixfmt-rfc-style
    obsidian
    nmap
    openvpn
    #hashcat
    #burpsuite
    #caido
    wireshark
    kdePackages.kate

    anki
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
    bluez
    protonvpn-gui
    #grub2
    xwayland
    xwayland-satellite
    nodejs_24
    typescript
    pnpm

    pv
    zstd
    dropbox
    rclone
    cryptomator
    calibre
    calibre-web
    # containers
    podman
    podman-compose
    podman-desktop
    kime
    adwaita-icon-theme # for fcitx icon?

    beancount
    fava

    gcolor3
  ];

  hardware = {
    enableAllFirmware = true;
    graphics.enable = true;
    nvidia = {
      modesetting.enable = true;
      open = false;
    };
    bluetooth = {
      enable = true;
      powerOnBoot = true;
      package = pkgs.bluez;
      settings = {
        General = {
          Enable = "Source,Sink,Media,Socket";
          AutoEnable = true;
          ControllerMode = "bredr";
          UserspaceHID = true;
          Experimental = true;
          FastConnectable = true;
        };
        Input = {
          ClassicBondedOnly = false;
        };
        Policy = {
          AutoEnable = true;
        };
      };
    };
  };
  boot.extraModprobeConfig = ''
    options bluetooth disable_ertm=1
  '';

  services.xserver.videoDrivers = [ "nvidia" ];

  xdg.portal.wlr.enable = true;
  fonts = {
    fontconfig.enable = true;
    packages = with pkgs; [
      noto-fonts
      noto-fonts-cjk-sans
      noto-fonts-color-emoji
      liberation_ttf
      fira-code
      fira-code-symbols
      nerd-fonts.jetbrains-mono
    ];
  };
  services = {
    displayManager.enable = true;
    displayManager.ly.enable = true;
    blueman.enable = true;
    openssh = {
      enable = true;

      settings = {
        PasswordAuthentication = false;
        KbdInteractiveAuthentication = false;
        PermitRootLogin = "no";
        PubkeyAuthentication = true;

        # Optional hardening
        # AllowTcpForwarding = "no";
        # X11Forwarding = false;
        # AllowAgentForwarding = false;
      };
    };
  };

  services.pulseaudio.enable = false;
  services.pipewire = {
    enable = true;
    pulse.enable = true;
    alsa.enable = true;
  };
  programs = {
    nix-ld.enable = true;
    niri.enable = true;
    xwayland.enable = true;
    wireshark.enable = true;

    _1password.enable = true;
    _1password-gui = {
      enable = true;
      polkitPolicyOwners = [ globals.UserName ];
    };

    steam = {
      enable = true;
      remotePlay.openFirewall = true;
      dedicatedServer.openFirewall = true;
    };
    gamemode.enable = true;
  };
  security.polkit.enable = true;
  # virtualisation.docker.enable = true;

  environment.variables = {
    LD_LIBRARY_PATH = "/run/opengl-driver/lib";
    ELECTRON_OZONE_PLATFORM_HINT = "wayland";
    OZONE_PLATFORM = "wayland";
    GDK_BACKEND = "wayland";
  };
  # enable containerization ( podman )
  programs.virt-manager.enable = true;
  virtualisation.containers.enable = true;
  virtualisation = {
    libvirtd = {
      enable = true;
    };
    podman = {
      enable = true;

      # Create a `docker` alias for podman, to use it as a drop-in replacement
      dockerCompat = true;

      # Required for containers under podman-compose to be able to talk to each other.
      defaultNetwork.settings.dns_enabled = true;
    };
  };

  systemd.services.toggle-gpp-on-suspend = {
    description = "Toggle GPP wake pins around suspend to prevent fan/spurious wake issues";
    wantedBy = [ "sleep.target" ];
    before = [ "sleep.target" ];

    serviceConfig = {
      Type = "oneshot";
      RemainAfterExit = true;
      ExecStart = ''
        # Runs BEFORE suspend: disable wake pins
        ${pkgs.bash}/bin/bash -c 'echo GPP0 > /proc/acpi/wakeup'
        ${pkgs.bash}/bin/bash -c 'echo GPP8 > /proc/acpi/wakeup'
      '';
      ExecStop = ''
        # Runs AFTER resume: restore wake pins
        ${pkgs.bash}/bin/bash -c 'echo GPP0 > /proc/acpi/wakeup'
        ${pkgs.bash}/bin/bash -c 'echo GPP8 > /proc/acpi/wakeup'
      '';
    };
  };
  # systemd.services.disable-acpi-wakeup = {
  #   description = "Disable ACPI wakeup on user login";
  #
  #   wantedBy = [ "multi-user.target" ];
  #   after = [ "systemd-logind.service" ];
  #
  #   serviceConfig = {
  #     Type = "oneshot";
  #     ExecStart = [
  #       "${pkgs.bash}/bin/bash -c 'echo GPP0 > /proc/acpi/wakeup'"
  #       "${pkgs.bash}/bin/bash -c 'echo GPP8 > /proc/acpi/wakeup'"
  #     ];
  #   };
  # };
  services.gvfs.enable = true; # enables trash for file explorer
  nix = {
    settings = {
      experimental-features = [
        "nix-command"
        "flakes"
      ];
    };
    gc = {
      automatic = true;
      dates = "daily";
      options = "--delete-older-than 30d";
    };
  };

  networking.firewall.allowedTCPPorts = [ 22 ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # networking.firewall.enable = false;
  system.stateVersion = "25.11";

  services.udev.extraRules = ''
    # Rules for Oryx web flashing and live training
    KERNEL=="hidraw*", ATTRS{idVendor}=="16c0", MODE="0664", GROUP="plugdev"
    KERNEL=="hidraw*", ATTRS{idVendor}=="3297", MODE="0664", GROUP="plugdev"

    # Legacy rules for live training over webusb (Not needed for firmware v21+)
      # Rule for all ZSA keyboards
      SUBSYSTEM=="usb", ATTR{idVendor}=="3297", GROUP="plugdev"
      # Rule for the Moonlander
      SUBSYSTEM=="usb", ATTR{idVendor}=="3297", ATTR{idProduct}=="1969", GROUP="plugdev"
      # Rule for the Ergodox EZ
      SUBSYSTEM=="usb", ATTR{idVendor}=="feed", ATTR{idProduct}=="1307", GROUP="plugdev"
      # Rule for the Planck EZ
      SUBSYSTEM=="usb", ATTR{idVendor}=="feed", ATTR{idProduct}=="6060", GROUP="plugdev"

    # Wally Flashing rules for the Ergodox EZ
    ATTRS{idVendor}=="16c0", ATTRS{idProduct}=="04[789B]?", ENV{ID_MM_DEVICE_IGNORE}="1"
    ATTRS{idVendor}=="16c0", ATTRS{idProduct}=="04[789A]?", ENV{MTP_NO_PROBE}="1"
    SUBSYSTEMS=="usb", ATTRS{idVendor}=="16c0", ATTRS{idProduct}=="04[789ABCD]?", MODE:="0666"
    KERNEL=="ttyACM*", ATTRS{idVendor}=="16c0", ATTRS{idProduct}=="04[789B]?", MODE:="0666"

    # Keymapp / Wally Flashing rules for the Moonlander and Planck EZ
    SUBSYSTEMS=="usb", ATTRS{idVendor}=="0483", ATTRS{idProduct}=="df11", MODE:="0666", SYMLINK+="stm32_dfu"
    # Keymapp Flashing rules for the Voyager
    SUBSYSTEMS=="usb", ATTRS{idVendor}=="3297", MODE:="0666", SYMLINK+="ignition_dfu"
    # 8Bitdo F30 P1
    SUBSYSTEM=="input", ATTRS{name}=="8Bitdo FC30 GamePad", ENV{ID_INPUT_JOYSTICK}="1", TAG+="uaccess"
    # 8Bitdo F30 P2
    SUBSYSTEM=="input", ATTRS{name}=="8Bitdo FC30 II", ENV{ID_INPUT_JOYSTICK}="1", TAG+="uaccess"
    # 8Bitdo N30
    SUBSYSTEM=="input", ATTRS{name}=="8Bitdo NES30 GamePad", ENV{ID_INPUT_JOYSTICK}="1", TAG+="uaccess"
    # 8Bitdo SF30
    SUBSYSTEM=="input", ATTRS{name}=="8Bitdo SFC30 GamePad", ENV{ID_INPUT_JOYSTICK}="1", TAG+="uaccess"
    # 8Bitdo SN30
    SUBSYSTEM=="input", ATTRS{name}=="8Bitdo SNES30 GamePad", ENV{ID_INPUT_JOYSTICK}="1", TAG+="uaccess"
    # 8Bitdo F30 Pro
    SUBSYSTEM=="input", ATTRS{name}=="8Bitdo FC30 Pro", ENV{ID_INPUT_JOYSTICK}="1", TAG+="uaccess"
    # 8Bitdo N30 Pro
    SUBSYSTEM=="input", ATTRS{name}=="8Bitdo NES30 Pro", ENV{ID_INPUT_JOYSTICK}="1", TAG+="uaccess"
    # 8Bitdo SF30 Pro
    SUBSYSTEM=="input", ATTRS{name}=="8Bitdo SF30 Pro", ENV{ID_INPUT_JOYSTICK}="1", TAG+="uaccess"
    # 8Bitdo SN30 Pro
    SUBSYSTEM=="input", ATTRS{name}=="8Bitdo SN30 Pro", ENV{ID_INPUT_JOYSTICK}="1", TAG+="uaccess"
    # 8BitDo SN30 Pro+; Bluetooth; USB
    SUBSYSTEM=="input", ATTRS{name}=="8BitDo SN30 Pro+", ENV{ID_INPUT_JOYSTICK}="1", TAG+="uaccess"
    SUBSYSTEM=="input", ATTRS{name}=="8Bitdo SF30 Pro   8BitDo SN30 Pro+", ENV{ID_INPUT_JOYSTICK}="1", TAG+="uaccess"
    # 8Bitdo F30 Arcade
    SUBSYSTEM=="input", ATTRS{name}=="8Bitdo Joy", ENV{ID_INPUT_JOYSTICK}="1", TAG+="uaccess"
    # 8Bitdo N30 Arcade
    SUBSYSTEM=="input", ATTRS{name}=="8Bitdo NES30 Arcade", ENV{ID_INPUT_JOYSTICK}="1", TAG+="uaccess"
    # 8Bitdo ZERO
    SUBSYSTEM=="input", ATTRS{name}=="8Bitdo Zero GamePad", ENV{ID_INPUT_JOYSTICK}="1", TAG+="uaccess"
    # 8Bitdo Retro-Bit xRB8-64
    SUBSYSTEM=="input", ATTRS{name}=="8Bitdo N64 GamePad", ENV{ID_INPUT_JOYSTICK}="1", TAG+="uaccess"
    # 8BitDo Pro 2; Bluetooth; USB
    SUBSYSTEM=="input", ATTRS{name}=="8BitDo Pro 2", ENV{ID_INPUT_JOYSTICK}="1", TAG+="uaccess"
    SUBSYSTEM=="input", ATTR{id/vendor}=="2dc8", ATTR{id/product}=="6003", ENV{ID_INPUT_JOYSTICK}="1", TAG+="uaccess"
    # Alpha Imaging Technology Corp.
    KERNEL=="hidraw*", SUBSYSTEM=="hidraw", ATTRS{idVendor}=="114d", ATTRS{idProduct}=="8a12", TAG+="uaccess"
    # ASTRO Gaming C40 Controller; USB
    KERNEL=="hidraw*", ATTRS{idVendor}=="9886", ATTRS{idProduct}=="0025", MODE="0660", TAG+="uaccess"
    # Betop PS4 Fun Controller
    KERNEL=="hidraw*", ATTRS{idVendor}=="11c0", ATTRS{idProduct}=="4001", MODE="0660", TAG+="uaccess"
    # Hori RAP4
    KERNEL=="hidraw*", ATTRS{idVendor}=="0f0d", ATTRS{idProduct}=="008a", MODE="0660", TAG+="uaccess"
    # Hori HORIPAD 4 FPS
    KERNEL=="hidraw*", ATTRS{idVendor}=="0f0d", ATTRS{idProduct}=="0055", MODE="0660", TAG+="uaccess"
    # Hori HORIPAD 4 FPS Plus
    KERNEL=="hidraw*", ATTRS{idVendor}=="0f0d", ATTRS{idProduct}=="0066", MODE="0660", TAG+="uaccess"
    # Hori HORIPAD S; USB
    KERNEL=="hidraw*", ATTRS{idVendor}=="0f0d", ATTRS{idProduct}=="00c1", MODE="0660", TAG+="uaccess"
    # Hori Nintendo Switch HORIPAD Wired Controller; USB
    KERNEL=="hidraw*", ATTRS{idVendor}=="0f0d", ATTRS{idProduct}=="00c1", MODE="0660", TAG+="uaccess"
    # HTC
    KERNEL=="hidraw*", SUBSYSTEM=="hidraw", ATTRS{idVendor}=="0bb4", ATTRS{idProduct}=="2c87", TAG+="uaccess"
    KERNEL=="hidraw*", SUBSYSTEM=="hidraw", ATTRS{idVendor}=="0bb4", ATTRS{idProduct}=="0306", TAG+="uaccess"
    KERNEL=="hidraw*", SUBSYSTEM=="hidraw", ATTRS{idVendor}=="0bb4", ATTRS{idProduct}=="0309", TAG+="uaccess"
    KERNEL=="hidraw*", SUBSYSTEM=="hidraw", ATTRS{idVendor}=="0bb4", ATTRS{idProduct}=="030a", TAG+="uaccess"
    KERNEL=="hidraw*", SUBSYSTEM=="hidraw", ATTRS{idVendor}=="0bb4", ATTRS{idProduct}=="030b", TAG+="uaccess"
    KERNEL=="hidraw*", SUBSYSTEM=="hidraw", ATTRS{idVendor}=="0bb4", ATTRS{idProduct}=="030c", TAG+="uaccess"
    KERNEL=="hidraw*", SUBSYSTEM=="hidraw", ATTRS{idVendor}=="0bb4", ATTRS{idProduct}=="030e", TAG+="uaccess"
    # HTC VIVE Cosmos; USB; https://gitlab.com/fabis_cafe/game-devices-udev/-/issues/1/ #EXPERIMENTAL
    KERNEL=="hidraw*", SUBSYSTEM=="hidraw", ATTRS{idVendor}=="0bb4", ATTRS{idProduct}=="0313", TAG+="uaccess"
    SUBSYSTEM=="usb", ENV{DEVTYPE}=="usb_device", ATTRS{idVendor}=="057e", ATTRS{idProduct}=="0315", MODE="0660", TAG+="uaccess"
    SUBSYSTEM=="usb", ENV{DEVTYPE}=="usb_device", ATTRS{idVendor}=="057e", ATTRS{idProduct}=="0323", MODE="0660", TAG+="uaccess"
    # Logitech F310 Gamepad; USB
    KERNEL=="hidraw*", ATTRS{idVendor}=="046d", ATTRS{idProduct}=="c216", MODE="0660", TAG+="uaccess"
    # Logitech F710 Wireless Gamepad; USB #EXPERIMENTAL
    KERNEL=="hidraw*", ATTRS{idVendor}=="046d", ATTRS{idProduct}=="c21f", MODE="0660", TAG+="uaccess"
    # Mad Catz Street Fighter V Arcade FightPad PRO
    KERNEL=="hidraw*", ATTRS{idVendor}=="0738", ATTRS{idProduct}=="8250", MODE="0660", TAG+="uaccess"
    # Mad Catz Street Fighter V Arcade FightStick TE S+
    KERNEL=="hidraw*", ATTRS{idVendor}=="0738", ATTRS{idProduct}=="8384", MODE="0660", TAG+="uaccess"
    # Microsoft Xbox360 Controller; USB #EXPERIMENTAL
    SUBSYSTEM=="usb", ATTRS{idVendor}=="045e", ATTRS{idProduct}=="028e", MODE="0660", TAG+="uaccess"
    SUBSYSTEMS=="input", ATTRS{name}=="Microsoft X-Box 360 pad", MODE="0660", TAG+="uaccess"
    # Microsoft Xbox 360 Wireless Receiver for Windows; USB
    SUBSYSTEM=="usb", ATTRS{idVendor}=="045e", ATTRS{idProduct}=="0719", MODE="0660", TAG+="uaccess"
    SUBSYSTEMS=="input", ATTRS{name}=="Xbox 360 Wireless Receiver", MODE="0660", TAG+="uaccess"
    # Microsoft Xbox One S Controller; bluetooth; USB #EXPERIMENTAL
    KERNEL=="hidraw*", KERNELS=="*045e:02ea*", MODE="0660", TAG+="uaccess"
    SUBSYSTEMS=="usb", ATTRS{idVendor}=="045e", ATTRS{idProduct}=="02ea", MODE="0660", TAG+="uaccess"
    # Nacon PS4 Revolution Pro Controller
    KERNEL=="hidraw*", ATTRS{idVendor}=="146b", ATTRS{idProduct}=="0d01", MODE="0660", TAG+="uaccess"
    # Nintendo Switch Pro Controller; bluetooth; USB
    KERNEL=="hidraw*", KERNELS=="*057E:2009*", MODE="0660", TAG+="uaccess"
    KERNEL=="hidraw*", ATTRS{idVendor}=="057e", ATTRS{idProduct}=="2009", MODE="0660", TAG+="uaccess"
    # Nintendo GameCube Controller / Adapter; USB
    SUBSYSTEM=="usb", ENV{DEVTYPE}=="usb_device", ATTRS{idVendor}=="057e", ATTRS{idProduct}=="0337", MODE="0660", TAG+="uaccess"
    # NVIDIA Shield Portable (2013 - NVIDIA_Controller_v01.01 - In-Home Streaming only)
    KERNEL=="hidraw*", ATTRS{idVendor}=="0955", ATTRS{idProduct}=="7203", ENV{ID_INPUT_JOYSTICK}="1", ENV{ID_INPUT_MOUSE}="", MODE="0660", TAG+="uaccess"
    # NVIDIA Shield Controller (2017 - NVIDIA_Controller_v01.04); bluetooth
    KERNEL=="hidraw*", KERNELS=="*0955:7214*", MODE="0660", TAG+="uaccess"
    # NVIDIA Shield Controller (2015 - NVIDIA_Controller_v01.03); USB
    KERNEL=="hidraw*", ATTRS{idVendor}=="0955", ATTRS{idProduct}=="7210", ENV{ID_INPUT_JOYSTICK}="1", ENV{ID_INPUT_MOUSE}="", MODE="0660", TAG+="uaccess"
    # PDP Afterglow Deluxe+ Wired Controller; USB
    KERNEL=="hidraw*", ATTRS{idVendor}=="0e6f", ATTRS{idProduct}=="0188", MODE="0660", TAG+="uaccess"
    # PDP Nintendo Switch Faceoff Wired Pro Controller; USB
    KERNEL=="hidraw*", ATTRS{idVendor}=="0e6f", ATTRS{idProduct}=="0180", MODE="0660", TAG+="uaccess"
    # PDP Wired Fight Pad Pro for Nintendo Switch; USB
    KERNEL=="hidraw*", ATTRS{idVendor}=="0e6f", ATTRS{idProduct}=="0185", MODE="0666", TAG+="uaccess"
    # Personal Communication Systems, Inc. Twin USB Gamepad; USB
    KERNEL=="hidraw*", ATTRS{idVendor}=="0810", ATTRS{idProduct}=="e301", MODE="0660", TAG+="uaccess"
    SUBSYSTEM=="input", ATTRS{name}=="Twin USB Gamepad*", ENV{ID_INPUT_JOYSTICK}="1", TAG+="uaccess"
    # PowerA Wired Controller for Nintendo Switch; USB
    KERNEL=="hidraw*", ATTRS{idVendor}=="20d6", ATTRS{idProduct}=="a711", MODE="0660", TAG+="uaccess"
    # PowerA Zelda Wired Controller for Nintendo Switch; USB
    KERNEL=="hidraw*", ATTRS{idVendor}=="20d6", ATTRS{idProduct}=="a713", MODE="0660", TAG+="uaccess"
    # PowerA Wireless Controller for Nintendo Switch; bluetooth
    # We have to use ATTRS{name} since VID/PID are reported as zeros.
    # We use sh instead of udevadm directly becuase we need to
    # use '*' glob at the end of "hidraw" name since we don't know the index it'd have.
    # Thanks @https://github.com/ValveSoftware
    # KERNEL=="input*", ATTRS{name}=="Lic Pro Controller", RUN{program}+="sh -c 'udevadm test-builtin uaccess /sys/%p/../../hidraw/hidraw*'"
    # Razer Raiju PS4 Controller
    KERNEL=="hidraw*", ATTRS{idVendor}=="1532", ATTRS{idProduct}=="1000", MODE="0660", TAG+="uaccess"
    # Razer Panthera Arcade Stick
    KERNEL=="hidraw*", ATTRS{idVendor}=="1532", ATTRS{idProduct}=="0401", MODE="0660", TAG+="uaccess"
    # Sony PlayStation Strikepack; USB
    KERNEL=="hidraw*", ATTRS{idVendor}=="054c", ATTRS{idProduct}=="05c5", MODE="0660", TAG+="uaccess"
    # Sony PlayStation DualShock 3; bluetooth; USB
    KERNEL=="hidraw*", KERNELS=="*054C:0268*", MODE="0660", TAG+="uaccess"
    KERNEL=="hidraw*", ATTRS{idVendor}=="054c", ATTRS{idProduct}=="0268", MODE="0660", TAG+="uaccess"
    ## Motion Sensors
    SUBSYSTEM=="input", KERNEL=="event*|input*", KERNELS=="*054C:0268*", TAG+="uaccess"
    # Sony PlayStation DualShock 4; bluetooth; USB
    KERNEL=="hidraw*", KERNELS=="*054C:05C4*", MODE="0660", TAG+="uaccess"
    KERNEL=="hidraw*", ATTRS{idVendor}=="054c", ATTRS{idProduct}=="05c4", MODE="0660", TAG+="uaccess"
    # Sony PlayStation DualShock 4 Slim; bluetooth; USB
    KERNEL=="hidraw*", KERNELS=="*054C:09CC*", MODE="0660", TAG+="uaccess"
    KERNEL=="hidraw*", ATTRS{idVendor}=="054c", ATTRS{idProduct}=="09cc", MODE="0660", TAG+="uaccess"
    # Sony PlayStation DualShock 4 Wireless Adapter; USB
    KERNEL=="hidraw*", ATTRS{idVendor}=="054c", ATTRS{idProduct}=="0ba0", MODE="0660", TAG+="uaccess"
    # Sony DualSense Wireless-Controller; bluetooth; USB
    KERNEL=="hidraw*", KERNELS=="*054C:0CE6*", MODE="0660", TAG+="uaccess"
    KERNEL=="hidraw*", ATTRS{idVendor}=="054c", ATTRS{idProduct}=="0ce6", MODE="0660", TAG+="uaccess"
    # PlayStation VR; USB
    SUBSYSTEM=="usb", ATTR{idVendor}=="054c", ATTR{idProduct}=="09af", MODE="0660", TAG+="uaccess"
    # Valve generic(all) USB devices
    SUBSYSTEM=="usb", ATTRS{idVendor}=="28de", MODE="0660", TAG+="uaccess"
    # Valve Steam Controller write access
    KERNEL=="uinput", SUBSYSTEM=="misc", TAG+="uaccess", OPTIONS+="static_node=uinput"
    # Valve HID devices; bluetooth; USB
    KERNEL=="hidraw*", KERNELS=="*28DE:*", MODE="0660", TAG+="uaccess"
    KERNEL=="hidraw*", ATTRS{idVendor}=="28de", MODE="0660", TAG+="uaccess"
    # Valve
    KERNEL=="hidraw*", SUBSYSTEM=="hidraw", ATTRS{idVendor}=="28de", ATTRS{idProduct}=="1043", MODE="0660", TAG+="uaccess"
    KERNEL=="hidraw*", SUBSYSTEM=="hidraw", ATTRS{idVendor}=="28de", ATTRS{idProduct}=="1142", MODE="0660", TAG+="uaccess"
    KERNEL=="hidraw*", SUBSYSTEM=="hidraw", ATTRS{idVendor}=="28de", ATTRS{idProduct}=="2000", MODE="0660", TAG+="uaccess"
    KERNEL=="hidraw*", SUBSYSTEM=="hidraw", ATTRS{idVendor}=="28de", ATTRS{idProduct}=="2010", MODE="0660", TAG+="uaccess"
    KERNEL=="hidraw*", SUBSYSTEM=="hidraw", ATTRS{idVendor}=="28de", ATTRS{idProduct}=="2011", MODE="0660", TAG+="uaccess"
    KERNEL=="hidraw*", SUBSYSTEM=="hidraw", ATTRS{idVendor}=="28de", ATTRS{idProduct}=="2012", MODE="0660", TAG+="uaccess"
    KERNEL=="hidraw*", SUBSYSTEM=="hidraw", ATTRS{idVendor}=="28de", ATTRS{idProduct}=="2021", MODE="0660", TAG+="uaccess"
    KERNEL=="hidraw*", SUBSYSTEM=="hidraw", ATTRS{idVendor}=="28de", ATTRS{idProduct}=="2022", MODE="0660", TAG+="uaccess"
    KERNEL=="hidraw*", SUBSYSTEM=="hidraw", ATTRS{idVendor}=="28de", ATTRS{idProduct}=="2050", MODE="0660", TAG+="uaccess"
    KERNEL=="hidraw*", SUBSYSTEM=="hidraw", ATTRS{idVendor}=="28de", ATTRS{idProduct}=="2101", MODE="0660", TAG+="uaccess"
    KERNEL=="hidraw*", SUBSYSTEM=="hidraw", ATTRS{idVendor}=="28de", ATTRS{idProduct}=="2102", MODE="0660", TAG+="uaccess"
    KERNEL=="hidraw*", SUBSYSTEM=="hidraw", ATTRS{idVendor}=="28de", ATTRS{idProduct}=="2150", MODE="0660", TAG+="uaccess"
    KERNEL=="hidraw*", SUBSYSTEM=="hidraw", ATTRS{idVendor}=="28de", ATTRS{idProduct}=="2300", MODE="0660", TAG+="uaccess"
    KERNEL=="hidraw*", SUBSYSTEM=="hidraw", ATTRS{idVendor}=="28de", ATTRS{idProduct}=="2301", MODE="0660", TAG+="uaccess"
    # Zeroplus(ZP) appears to be a tech-provider for variouse other companies.
    # They all use the ZP ID. Because of this, they are grouped in this rule.
    # Armor PS4 Armor 3 Pad; USB
    KERNEL=="hidraw*", ATTRS{idVendor}=="0c12", ATTRS{idProduct}=="0e10", MODE="0660", TAG+="uaccess"
    # EMiO PS4 Elite Controller; USB
    KERNEL=="hidraw*", ATTRS{idVendor}=="0c12", ATTRS{idProduct}=="1cf6", MODE="0660", TAG+="uaccess"
    # Hit Box Arcade HIT BOX PS4/PC version; USB
    KERNEL=="hidraw*", ATTRS{idVendor}=="0c12", ATTRS{idProduct}=="0ef6", MODE="0660", TAG+="uaccess"
    # Nyko Xbox Controller; USB
    KERNEL=="hidraw*", ATTRS{idVendor}=="0c12", ATTRS{idProduct}=="8801", MODE="0660", TAG+="uaccess"
    # Unknown-Brand Xbox Controller; USB
    KERNEL=="hidraw*", ATTRS{idVendor}=="0c12", ATTRS{idProduct}=="8802", MODE="0660", TAG+="uaccess"
    # Unknown-Brand Xbox Controller; USB
    KERNEL=="hidraw*", ATTRS{idVendor}=="0c12", ATTRS{idProduct}=="8810", MODE="0660", TAG+="uaccess"
    # PS5 DualSense controller over USB hidraw
    KERNEL=="hidraw*", ATTRS{idVendor}=="054c", ATTRS{idProduct}=="0ce6", MODE="0660", TAG+="uaccess"
    # PS5 DualSense controller over bluetooth hidraw
    KERNEL=="hidraw*", KERNELS=="*054C:0CE6*", MODE="0660", TAG+="uaccess"
  '';
}
