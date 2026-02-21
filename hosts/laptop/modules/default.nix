{ pkgs, lib, ... }:
{

  imports = [
  ];

  # Multi-gpu setup. TODO: build this conditionally depending on the host
  services.udev.extraRules = ''
    # Intel iGPU
    KERNEL=="card*", \
      KERNELS=="0000:00:02.0", \
      SUBSYSTEM=="drm", \
      SUBSYSTEMS=="pci", \
      SYMLINK+="dri/intel-igpu"

    # NVIDIA dGPU
    KERNEL=="card*", \
      KERNELS=="0000:01:00.0", \
      SUBSYSTEM=="drm", \
      SUBSYSTEMS=="pci", \
      SYMLINK+="dri/nvidia-dgpu"
  '';

}
