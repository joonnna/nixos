{ config, libs, pkgs, ... }:

{
  hardware.bluetooth.enable = true;
  hardware.pulseaudio.extraConfig = ''
    load-module module-switch-on-connect
    load-module module-bluez5-discover
  '';

  services.pipewire = {
    enable = true;
    alsa.enable = true;
    pulse.enable = true;
  };
}

