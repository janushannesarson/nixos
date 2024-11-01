{
  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.05";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixpkgs-small.url = "github:NixOS/nixpkgs/nixos-24.05-small";
    nixpkgs-master.url = "github:NixOS/nixpkgs";

    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    hyprland.url = "git+https://github.com/hyprwm/Hyprland?submodules=1";
    hyprland.inputs.nixpkgs.follows = "nixpkgs-unstable";
    #split-monitor-workspaces = {
    #  url = "github:Duckonaut/split-monitor-workspaces";
    #  inputs.hyprland.follows = "hyprland";
    #};
  };

  outputs = inputs @ { self, nixpkgs, ... }:
  {
    nixosConfigurations = nixpkgs.lib.nixosSystem {
      specialArgs = { inherit inputs; };
      modules = [ ./hosts/nixos/configuration.nix ];
    };
  };
}

