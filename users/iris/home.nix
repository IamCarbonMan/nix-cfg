{config, pkgs, ...}: {
    imports = [
        ./newm/newm.nix
    ];

    programs.home-manager.enable = true;

    programs.git = {
        enable = true;
        userName = "iris";
        userEmail = "<>";
    };

    programs.helix.enable = true;

    home.packages = with pkgs; [
        neofetch kitty google-chrome discord kitty
    ];
}