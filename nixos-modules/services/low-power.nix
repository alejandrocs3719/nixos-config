
{ inputs, config, lib, pkgs, ... }: {

 options = {
    battery.low-power.enable = 
      lib.mkEnableOption "enables low profile optimizations to reduce watt use";
 };

  config = lib.mkIf config.battery.low-power.enable {
  
    services.udev.extraRules = lib.mkDefault ''
      # Remove NVIDIA USB xHCI Host Controller devices, if present
      ACTION=="add", SUBSYSTEM=="pci", ATTR{vendor}=="0x10de", ATTR{class}=="0x0c0330", ATTR{power/control}="auto", ATTR{remove}="1"

      # Remove NVIDIA USB Type-C UCSI devices, if present
      ACTION=="add", SUBSYSTEM=="pci", ATTR{vendor}=="0x10de", ATTR{class}=="0x0c8000", ATTR{power/control}="auto", ATTR{remove}="1"

      # Remove NVIDIA Audio devices, if present
      ACTION=="add", SUBSYSTEM=="pci", ATTR{vendor}=="0x10de", ATTR{class}=="0x040300", ATTR{power/control}="auto", ATTR{remove}="1"

      # Remove NVIDIA VGA/3D controller devices
      ACTION=="add", SUBSYSTEM=="pci", ATTR{vendor}=="0x10de", ATTR{class}=="0x03[0-9]*", ATTR{power/control}="auto", ATTR{remove}="1"
    '';

    boot = {
      kernelParams = [
      "pcie_aspm.policy=powersupersave"
      "intel_pstate=passive"   # use schedutil with Intel
      "i915.enable_dc=4"       # deep c-states in iGPU
      "i915.enable_psr=1"      # Panel Self Refresh eDP
      "mitigations=auto"
      ];

      extraModprobeConfig = ''
        options i915 enable_dc=4
        options i915 enable_fbc=1
        options i915 enable_psr=1
        options i915 enable_guc=3
        blacklist nouveau
        options nouveau modeset=0
      ''; # Intel optimizations and Disable Nvidia GPU
    
      blacklistedKernelModules = lib.mkDefault [ "nouveau" "nvidia" ];

    };

    networking.networkmanager.wifi.powersave = true;
    services.pipewire.jack.enable = false;
    powerManagement.enable = true;
    powerManagement.cpuFreqGovernor = "schedutil";
    services.power-profiles-daemon.enable = false; # Override power-profiles-daemon

    services.tlp = {
      enable = true;
      settings = {
        TLP_DEFAULT_MODE = "BAT";
        CPU_SCALING_GOVERNOR_ON_AC = "schedutil";
        CPU_SCALING_GOVERNOR_ON_BAT = "schedutil";
        CPU_ENERGY_PERF_POLICY_ON_AC = "balance_power";
        CPU_ENERGY_PERF_POLICY_ON_BAT = "power";
        PCIE_ASPM_ON_AC = "default";
        PCIE_ASPM_ON_BAT = "powersupersave";
        RUNTIME_PM_ON_AC = "auto";
        RUNTIME_PM_ON_BAT = "auto";
        USB_AUTOSUSPEND = "1";
        WIFI_PWR_ON_AC = "on";
        WIFI_PWR_ON_BAT = "on";
        DEVICES_TO_DISABLE_ON_BAT = "bluetooth";
        DEVICES_TO_DISABLE_ON_STARTUP = "bluetooth";
        DISK_IDLE_SECS_ON_AC = "60";
        DISK_IDLE_SECS_ON_BAT = "30";
        SATA_LINKPWR_ON_AC = "med_power_with_dipm";
        SATA_LINKPWR_ON_BAT = "min_power";
        SOUND_POWER_SAVE_ON_AC = "1";
        SOUND_POWER_SAVE_ON_BAT = "1";
        PLATFORM_PROFILE_ON_AC = "balanced";
        PLATFORM_PROFILE_ON_BAT = "low-power";
      };
    };
    powerManagement.powertop.enable = true;
    services.thermald.enable = true;

    hardware.bluetooth.enable = lib.mkForce false;
	#    services.fwupd.enable = true;
    services.locate.enable = false;
    services.journald.extraConfig = ''
    SystemMaxUse=200M
    RuntimeMaxUse=100M
    MaxRetentionSec=1month
    '';
    # programs.ssh.startAgent = true;
    services.openssh.enable = lib.mkForce false;
    # libvirt
    # nsncd (?)
    # 
    hardware.opentabletdriver.enable = lib.mkForce false;
    programs.kdeconnect.enable = lib.mkForce false;

    virtualisation = {
      docker.enable = lib.mkForce false;
      libvirtd.enable = lib.mkForce false;
    };
  };
}

