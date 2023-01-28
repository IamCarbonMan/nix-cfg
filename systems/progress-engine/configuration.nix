{config, pkgs, ...}: {
    imports = [
        ./hardware-configuration.nix
    ];

    nix = {
        gc = {
            automatic = true;
            dates = "weekly";
            options = "--delete-older-than 30d";
        };
        settings.experimental-features = ["nix-command" "flakes"];
        config.allowUnfree = true;
    };

    boot = {
        loader = {
            systemd-boot.enable = true;
            efi.canTouchEfiVariables = true;
        };
        blacklistedKernelModules = ["pcspkr"];
    };

    hardware.cpu.intel.updateMicrocode = true;

    networking = {
        networkmanager.enable = true;
        hostName = "progress-engine";
        nameservers = ["1.1.1.1" "8.8.8.8"];
    };

    time = {
        timeZone = "US/Pacific";
        i18n.defaultLocale = "en_US.UTF-8";
    };

    environment.systemPackages = with pkgs; [
        git
        pulseaudio
    ];

    services.greetd = {
        enable = true;
        settings = rec {
            newm = {
                command = "${pkgs.newm}/bin/start-newm";
                user = "iris";
            };
            default_session = newm;
        };
    };

    users.users.iris = {
        isNormalUser = true;
        extraGroups = ["wheel" "input" "video" "networkmanager"];
    };
}