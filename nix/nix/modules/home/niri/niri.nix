{ config, pkgs, ... }:

{
  xdg.configFile."niri/config.kdl".source =
    config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/niri/.config/niri/config.kdl";
  xdg.configFile."swaylock/config".source = ./mocha.conf;
  home.file.".local/bin/nws.sh".source = ./nws.sh;

}
