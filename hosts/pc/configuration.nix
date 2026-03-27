# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{
  config,
  lib,
  pkgs,
  ...
}:

{
  imports = [
    ./hardware-configuration.nix
    #./networking/firewall.nix # Firewall rules for this host only
  ];
  # Temporary fix, remove when https://github.com/NixOS/nixpkgs/issues/483540 is closed.
  modules.desktop.hyprland.enable = true;
  modules.gaming.enable = true;
  modules.networking.sunshine.enable = true;
  modules.media.enable = true;
  modules.services.ddcutil.enable = true;

  modules.programs.nemo.enable = true;

  modules.virtualisation = {
    enable = true;
    virtualbox.enable = true;
  };

  modules.graphics.amd.enable = true;

  services.openssh = {
    enable = true;
    settings = {
      PasswordAuthentication = false;
      PermitRootLogin = "no";
    };
  };

  services.tailscale = {
    enable = true;
    # Enable tailscale at startup

    # If you would like to use a preauthorized key
    #authKeyFile = "/run/secrets/tailscale_key";

  };

  # ---------------- BOOT LOADER ----------------
  boot.loader.limine = {
    enable = true;
    maxGenerations = 10;
    # Dual Boot with Windows
    extraEntries = "";
  };
  boot.loader.efi.canTouchEfiVariables = true;

  # Boot kernel parameters
  boot.kernelParams = [
  ];

  # Use latest kernel.
  boot.kernelPackages = pkgs.linuxPackages_latest;

  # SWAP
  zramSwap = {
    enable = true;
    priority = 100;
    algorithm = "lz4";
    memoryPercent = 50;
  };

  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 15d";
  };
  nix.optimise.automatic = true;

  fileSystems."/mnt/ssd2tb" = {
    device = "/dev/disk/by-uuid/876c2a2d-019e-4cb0-ae89-7e680668a933";
    fsType = "ext4";
    options = [
      # If you don't have this options attribute, it'll default to "defaults"
      # boot options for fstab. Search up fstab mount options you can use
      "users" # Allows any user to mount and unmount
      "nofail" # Prevent system from failing if this drive doesn't mount
      "exec" # Permit execution of binaries and other executable files
    ];
  };

  hardware.bluetooth.enable = true;
  # # Fstab equivalent
  # fileSystems."/mnt/SSD" = {
  #  device = "/dev/disk/by-uuid/7428BB9E28BB5DB4";
  #  fsType = "ntfs";
  #  options = [
  #    "users" # Allows any user to mount and unmount
  #    "nofail" # Prevent system from failing if this drive doesn't mount
  #  ];
  #};

  networking.hostName = "nixgrandete"; # Define your hostname.
  # Pick only one of the below networking options.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  networking.networkmanager.enable = true; # Easiest to use and most distros use this by default.

  # Set your time zone.
  time.timeZone = "Europe/Madrid";

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Select internationalisation properties.
  # i18n.defaultLocale = "es_ES.UTF-8";

  i18n = {
    defaultLocale = "en_US.UTF-8"; # main system language
    extraLocaleSettings = {
      LC_TIME = "es_ES.UTF-8"; # spanish date
      LC_MONETARY = "es_ES.UTF-8";
      LC_NUMERIC = "es_ES.UTF-8";
      LC_PAPER = "es_ES.UTF-8";
      LC_MEASUREMENT = "es_ES.UTF-8";
    };
  };

  console = {
    font = "Lat2-Terminus16";
    keyMap = "es";
    #useXkbConfig = true; # use xkb.options in tty.
  };

  # Enable the X11 windowing system.
  # services.xserver.enable = true;
  services.xserver = {
    enable = true;
  };

  nixpkgs.config.allowUnfree = true;

  services.upower = {
    enable = true;
  };

  services.pipewire = {
    enable = true;
    # pulse.enable = true;
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  programs.zsh.enable = true;
  users.users.alejandro = {
    isNormalUser = true;
    shell = pkgs.zsh;
    extraGroups = [
      "wheel"
      "networkmanager"
    ]; # Enable ‘sudo’ for the user.
    packages = with pkgs; [
    ];
  };

  programs.firefox.enable = true;

  # You can use https://search.nixos.org/ to find more packages (and options).
  environment.systemPackages = with pkgs; [
    vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    wget
    git
    pciutils
    btop
    lua-language-server
    nil
    powertop
    vesktop
    jdk
    lsof
    nvme-cli
    gparted
    spotify
    alacritty
    texliveFull
    ntfs3g
    rsync
  ];

  programs.chromium.enable = true;

  fonts.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
  ];

  # Enable Nix Flakes:
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # Copy the NixOS configuration file and link it from the resulting system
  # (/run/current-system/configuration.nix). This is useful in case you
  # accidentally delete configuration.nix.
  # system.copySystemConfiguration = true;

  # This option defines the first version of NixOS you have installed on this particular machine,
  # and is used to maintain compatibility with application data (e.g. databases) created on older NixOS versions.
  #
  # Most users should NEVER change this value after the initial install, for any reason,
  # even if you've upgraded your system to a new NixOS release.
  #
  # This value does NOT affect the Nixpkgs version your packages and OS are pulled from,
  # so changing it will NOT upgrade your system - see https://nixos.org/manual/nixos/stable/#sec-upgrading for how
  # to actually do that.
  #
  # This value being lower than the current NixOS release does NOT mean your system is
  # out of date, out of support, or vulnerable.
  #
  # Do NOT change this value unless you have manually inspected all the changes it would make to your configuration,
  # and migrated your data accordingly.
  #
  # For more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion .
  system.stateVersion = "25.05"; # Did you read the comment?

}
