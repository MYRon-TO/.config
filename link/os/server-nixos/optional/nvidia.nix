{ config, pkgs, ... }:
{
  # RTX 4070 Ti SUPER (Ada) supports NVIDIA's open kernel modules.
  services.xserver.videoDrivers = [ "nvidia" ];
  hardware.graphics.enable = true;
  hardware.nvidia = {
    package = config.boot.kernelPackages.nvidiaPackages.stable;
    open = true;
    modesetting.enable = true;
    nvidiaSettings = true;
    # Preserve video memory across suspend; temporary storage must fit GPU memory.
    powerManagement.enable = true;
    powerManagement.finegrained = false;
  };

  # Install the toolkit without enabling CUDA rebuilds for all of nixpkgs.
  environment.systemPackages = [ pkgs.cudaPackages.cudatoolkit ];
}
