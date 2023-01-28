{
  description = "jbuchermn system config";

  inputs = {
    flake-utils.url = "github:numtide/flake-utils";
    
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nur.url = "github:nix-community/NUR";

    home-manager.url = "github:nix-community/home-manager/master";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    newmpkg.url = "github:jbuchermn/newm";
    newmpkg.inputs.nixpkgs.follows = "nixpkgs";
    pywm-fullscreenpkg.url = "github:jbuchermn/pywm-fullscreen";
    pywm-fullscreenpkg.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { nixpkgs, flake-utils, nur, home-manager, newmpkg, pywm-fullscreenpkg, ... }:
    flake-utils.lib.eachDefaultSystem (
        system: let
            stateVersion = "22.05";

            pkgs = import nixpkgs {
                inherit system;
                config = {
                    allowUnfree = true;
                };
                overlays = [
                    nur.overlay (self: super: {
                        newm = newmpkg.packages.${system}.newm;
                        pywm-fullscreen = pywm-fullscreenpkg.packages.${system}.pywm-fullscreen; 
                    })
                ];
            };

            lib = nixpkgs.lib;

            nixosSystem = modules: lib.nixosSystem {
                inherit system pkgs;
                modules = [ 
                    ({ config, pkgs, ... }: {
                        nix.registry.nixpkgs.flake = nixpkgs;
                    })
                ] ++ modules;
            };

            homeManagerConfiguration = { modules, username, homeDirectory, extraSpecialArgs ? {} }: home-manager.lib.homeManagerConfiguration {
                inherit pkgs;

                modules = [
                {
                    nix.registry.nixpkgs.flake = nixpkgs;
                }
                {
                    home = {
                    inherit username homeDirectory stateVersion;
                    };
                }
                ] ++ modules;
            };
        in {
            packages.nixosConfigurations = {
                progress-engine = nixosSystem [ 
                    ./systems/progress-engine/configuration.nix 
                ];
            }; 

            packages.homeManagerConfigurations = {
                iris = homeManagerConfiguration {
                    username = "iris";
                    homeDirectory = "/home/iris";
                    modules = [
                        ./users/iris/home.nix
                    ];
                };
            };
        }
    );
}