{
  config,
  pkgs,
  globals,
  ...
}:

{
  home.stateVersion = "25.05";

  imports = [
    ./waybar/waybar.nix
    ./niri/niri.nix
    ./bash.nix
    ./wofi.nix
    #./tmux.nix
    #./nvim.nix
    #./ghostty.nix
    ./git.nix
  ];

  dconf.settings = {
    "org/gnome/desktop/interface" = {
      color-scheme = "prefer-dark";
    };
  };
  gtk = {
    enable = true;
    theme.name = "Adwaita-dark";

    colorScheme = "dark";
  };
  qt = {
    enable = true;
    style.name = "adwaita-dark";
  };
  home.pointerCursor = {
    enable = true;
    gtk.enable = true;
    package = pkgs.catppuccin-cursors.mochaSapphire;
    name = "catppuccin-mocha-sapphire-cursors";
    size = 12;
  };

  ########################################
  # 🧬 Git config
  ########################################
  programs = {
    #go.enable = true;
    bash.enable = true;
    zoxide.enable = true;
    #obs-studio.enable = true;
    #obs-studio.plugins = [ pkgs.obs-studio-plugins.wlrobs ];

  };

  services.swww.enable = true;
  services.swaync.enable = true;

  systemd.user.services.dropbox = {
    Unit = {
      Description = "Dropbox service";
    };
    Install = {
      WantedBy = [ "default.target" ];
    };
    Service = {
      ExecStart = "${pkgs.dropbox}/bin/dropbox";
      Restart = "on-failure";
    };
  };
  # systemd.user.services.kime = {
  #   Unit = {
  #     Description = "Kime Input Method";
  #     After = [ "wayland-session.target" ];
  #   };
  #
  #   Service = {
  #     ExecStart = "${pkgs.kime}/bin/kime";
  #     Environment = [
  #       "XDG_CONFIG_HOME=%h/.config"
  #     ];
  #     Restart = "on-failure";
  #   };
  #
  #   Install = {
  #     WantedBy = [ "wayland-session.target" ];
  #   };
  # };
  # systemd.user.services.kime = {
  #   description = "Kime Input Method";
  #   wantedBy = [ "graphical-session.target" ];
  #   after = [ "graphical-session.target" ];
  #
  #   serviceConfig = {
  #     ExecStart = "${pkgs.kime}/bin/kime";
  #     Restart = "on-failure";
  #     Environment = [
  #       "XDG_CONFIG_HOME=%h/.config"
  #     ];
  #   };
  # };

}
