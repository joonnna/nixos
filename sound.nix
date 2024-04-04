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

  # module list https://www.freedesktop.org/wiki/Software/PulseAudio/Documentation/User/Modules/#module-bluetooth-discover
  hardware.pulseaudio.extraConfig = "
    load-module module-switch-on-connect
    load-module module-bluetooth-discover
    load-module module-bluetooth-policy
    unload-module module-suspend-on-idle
    unload-module module-jackdbus-detect
  ";

  services.blueman.enable = true;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    pulse.enable = true;
    jack.enable = false;
  };
}
