{
  description = "NixOS + Home Manager config";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs?ref=nixos-unstable";
    # nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.11";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    awww.url = "git+https://codeberg.org/LGFae/awww";
    zen-browser.url = "github:0xc000022070/zen-browser-flake";
    zen-browser.inputs.nixpkgs.follows = "nixpkgs";
    zen-browser.inputs.home-manager.follows = "home-manager";
  };

  outputs =
    {
      self,
      nixpkgs,
      home-manager,
      ...
    }@inputs:
    let
      system = "x86_64-linux";
      globals = {
        # this are the variables that you wanna change xd
        UserName = "jh";
        HostName = "nucleus";
        GitName = "Jeremy Hage";
        GitEmail = "jhage.codingkr@gmail.com";
        Bwserver = "";
      };

    in
    {
      nixosConfigurations.${globals.HostName} = nixpkgs.lib.nixosSystem {
        inherit system;
        specialArgs = { inherit globals inputs; };
        modules = [
          ./configuration.nix
          home-manager.nixosModules.home-manager
          {
            home-manager = {
              useGlobalPkgs = true;
              useUserPackages = true;
              extraSpecialArgs = { inherit globals inputs; };
              users.${globals.UserName} = import ./modules/home/home.nix;
              backupFileExtension = "backup";
            };
          }
        ];
      };
    };
}
