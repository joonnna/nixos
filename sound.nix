{ config, libs, pkgs, ... }:

{
  hardware.bluetooth = {
    enable = true;
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
  ";

  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    pulse.enable = true;
  };
}
