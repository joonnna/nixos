{ config, libs, pkgs, ... }:

{
  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
    settings = {
      General = {
        Enable = "Source,Sink,Media,Socket";
      };
    };
  };


  sound.enable = false;

  hardware.pulseaudio.extraConfig = "
    load-module module-switch-on-connect
    load-module module-bluetooth-policy
    load-module module-bluetooth-discover
    load-module module-bluez5-device
    load-module module-bluez5-discover
  ";

  services.blueman.enable = true;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    pulse.enable = true;
  };
}
