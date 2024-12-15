{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    hyprland.url = "git+https://github.com/hyprwm/Hyprland?submodules=1";
    hyprland.inputs.nixpkgs.follows = "nixpkgs";
    #split-monitor-workspaces = {
    #  url = "github:Duckonaut/split-monitor-workspaces";
    #  inputs.hyprland.follows = "hyprland";
    #};
  };

  outputs = inputs @ { self, nixpkgs, ... }:
  {
    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
	  system = "x86_64-linux";
      specialArgs = { inherit inputs; };
      modules = [ ./hosts/nixos/configuration.nix ];
    };
    nixosConfigurations.nixos-xps13 = nixpkgs.lib.nixosSystem {
	  system = "x86_64-linux";
      specialArgs = { inherit inputs; };
      modules = [ ./hosts/nixos-xps13/configuration.nix ];
    };
  };
}

