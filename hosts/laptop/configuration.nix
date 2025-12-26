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
    ./modules # Modules made for this host only
    ./networking/firewall.nix # Firewall rules for this host only
  ];

  modules.desktop.niri.enable = true;
  modules.gaming.enable = true;
  modules.networking.sunshine.enable = true;
  modules.media.enable = true;

  battery.power-profiles-daemon.enable = true;
  asus.enable = true;
  programs.thunar.enable = true;
  modules.theming.stylix.enable = true;
  graphics.nvidia.enable = true;
  graphics.intel.enable = true;
  

  # ---------------- BOOT LOADER ----------------
  boot.loader.limine = {
    enable = true;
    style.interface.resolution = "2560x1600";
  };
  boot.loader.efi.canTouchEfiVariables = true;

  # Boot kernel parameters
  boot.kernelParams = [
    "i915.enable_dpcd_backlight=1"
    "nvidia.NVreg_EnableBacklightHandler=0"
    "nvidia.NVreg_RegistryDwords=EnableBrightnessControl=0"
  ];

  # Use latest kernel.
  boot.kernelPackages = pkgs.linuxPackages_cachyos;
  services.scx.enable = true; # by default uses scx_rustland scheduler
  # boot.kernelPackages = pkgs.linuxPackages_latest;


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
    options = "--delete-older-than 30d";
  };
  nix.optimise.automatic = true;



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

  networking.hostName = "nixandrete"; # Define your hostname.
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
    autoRepeatDelay = 200;
    autoRepeatInterval = 35; # Key repeat rate, useful for navigating vim
  };
  # Power management

  # services.tlp = {
  #     enable = true;
  #     settings = {
  #       CPU_SCALING_GOVERNOR_ON_AC = "performance";
  #       CPU_SCALING_GOVERNOR_ON_BAT = "powersave";

  #       CPU_ENERGY_PERF_POLICY_ON_BAT = "power";
  #       CPU_ENERGY_PERF_POLICY_ON_AC = "performance";

  #       CPU_MIN_PERF_ON_AC = 0;
  #       CPU_MAX_PERF_ON_AC = 100;
  #       CPU_MIN_PERF_ON_BAT = 0;
  #       CPU_MAX_PERF_ON_BAT = 20;

  #      #Optional helps save long term battery health
  #           #START_CHARGE_THRESH_BAT0 = 40; # 40 and below it starts to charge
  #      STOP_CHARGE_THRESH_BAT0 = 80; # 80 and above it stops charging

  #     };
  # };
  # Richard Stallman is crying:
  nixpkgs.config.allowUnfree = true;

  services.upower = {
    enable = true;
  };

  services.pipewire = {
    enable = true;
    # pulse.enable = true;
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.alejandro = {
    isNormalUser = true;
    extraGroups = [
      "wheel"
      "networkmanager"
    ]; # Enable ‘sudo’ for the user.
    packages = with pkgs; [
      tree
    ];
  };

  programs.firefox.enable = true;

  # You can use https://search.nixos.org/ to find more packages (and options).
  environment.systemPackages = with pkgs; [
    vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    wget
    git
    btop
    lua-language-server
    nil
    prismlauncher
    powertop
    vesktop
    jdk
    lsof
    nvme-cli
    gparted
    #hyprpolkitagent
    spotify
    xwayland-satellite
    alacritty
    #  vmware-workstation
    # brave
  ];

  programs.chromium.enable = true;

  #virtualisation.vmware.host.enable = true;

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
