{ config, libs, pkgs, ... }:

{
  hardware.bluetooth.enable = true;
  hardware.pulseaudio.extraConfig = " load-module module-switch-on-connect ";

  services.pipewire = {
    enable = true;
    alsa.enable = true;
    pulse.enable = true;
  };
}

