{ pkgs, ... }:
let
  # Wrapper for brightnessctl that defaults to intel_backlight and changes both devices
  brightnessctl-hybrid = pkgs.writeShellScriptBin "brightnessctl" ''
    # Wrapper for brightnessctl on hybrid laptops
    # Always use intel_backlight unless -d is specified
    # This ensures noctalia-shell uses the correct backlight

    if [[ "$*" == *"-d"* ]]; then
      # User specified device, pass through
      exec ${pkgs.brightnessctl}/bin/brightnessctl "$@"
    else
      # No device specified, use intel_backlight and mirror to nvidia_0
      ${pkgs.brightnessctl}/bin/brightnessctl -d intel_backlight "$@"
      # Also set nvidia_0 to keep them in sync
      ${pkgs.brightnessctl}/bin/brightnessctl -d nvidia_0 "$@" 2>/dev/null || true
    fi
  '';
in
{
  # Override brightnessctl package with our wrapper by placing it earlier in PATH
  environment.systemPackages = with pkgs; [
    (lib.hiPrio brightnessctl-hybrid) # Higher priority than regular brightnessctl
  ];

  # Allow users in video group to control backlight
  #  hardware.brillo.enable = true;

  # Set proper permissions on backlight devices for video group
  services.udev.extraRules = ''
    ACTION=="add", SUBSYSTEM=="backlight", KERNEL=="intel_backlight", RUN+="${pkgs.coreutils}/bin/chmod 0666 /sys/class/backlight/%k/brightness"
    ACTION=="add", SUBSYSTEM=="backlight", KERNEL=="nvidia_0", RUN+="${pkgs.coreutils}/bin/chmod 0666 /sys/class/backlight/%k/brightness"
    ACTION=="change", SUBSYSTEM=="backlight", KERNEL=="intel_backlight", RUN+="${pkgs.coreutils}/bin/chmod 0666 /sys/class/backlight/%k/brightness"
    ACTION=="change", SUBSYSTEM=="backlight", KERNEL=="nvidia_0", RUN+="${pkgs.coreutils}/bin/chmod 0666 /sys/class/backlight/%k/brightness"
  '';
}
