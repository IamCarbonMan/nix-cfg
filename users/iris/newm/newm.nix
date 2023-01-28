input@{config, pkgs, ...}: {
    home.packages = with pkgs; [
        newm pywm-fullscreen
    ];

    xdg.configFile."newm/config.py".source = ./config.py;

    home.sessionVariables = {
        XDG_SESSION_TYPE = "wayland";
        XDG_SESSION_DESKTOP = "wlroots";
        XDG_CURRENT_DESKTOP = "wlroots";
        XDG_CURRENT_SESSION = "wlroots";
        NIXOS_OZONE_WL = "1";
    };

    home.file."wallpaper.png".source = ./wallpaper.png;
}