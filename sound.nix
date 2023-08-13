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

  # source: https://nixos.wiki/wiki/PipeWire
  # testing if this avoid crackling sound (interruption in audio output)
  environment.etc = {
    "pipewire/pipewire.conf.d/92-low-latency.conf".text = ''
      context.properties = {
        default.clock.rate = 48000
        default.clock.quantum = 32
        default.clock.min-quantum = 32
        default.clock.max-quantum = 32
      }
    '';
  };
}

