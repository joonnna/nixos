{ pkgs, lib, ... }:
{
  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
    settings = {
      General = {
        Experimental = true;
        FastConnectable = "true";
        ControllerMode = "bredr";
      };
      Policy = {
        AutoEnable = "true";
      };
    };
  };


  systemd.services.bluetooth.serviceConfig.ExecStart = lib.mkForce [
    ""
    "${pkgs.bluez}/libexec/bluetooth/bluetoothd -f /etc/bluetooth/main.conf -E"
  ];

  security.rtkit.enable = true;

  # See comment for info on pipewire/alsa/jack/pulse relationship
  # https://www.reddit.com/r/linuxaudio/comments/1jkvwb6/alsa_vs_pulseaudio_vs_jack_vs_pipewire/
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    pulse.enable = true;
    jack.enable = false;
  };
}
