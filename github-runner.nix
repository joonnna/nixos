{ pkgs, ... }:

{

  services.github-runners."gengar" = {
    enable = true;
    user = "jon";
    group = "users";
    name = "local-live-game-streamer";
    tokenFile = "/home/jon/github-runner-pat.token";
    url = "https://github.com/orcalabs/gengar";
    extraLabels = [ "gengar-gpu" ];
    replace = true;
    workDir = "/home/jon/github-runner-workspace";
    serviceOverrides = {
      ReadWritePaths = [
        "/home/jon/github-runner-workspace"
      ];
      ProtectHome = false;
      ProtectUsers = false;
    };
  };


  systemd.user.services.gengar-engine = {
    enable = true;
    path = [ pkgs.nix ];
    script = ''
      /home/jon/github-runner-workspace/gengar/gengar/github-local-runner/run.sh
    '';
    wantedBy = [ "multi-user.target" ];
    serviceConfig = {
      Restart = "always";
      RestartSec = 60;
    };
  };

  systemd.user.services.gengar-engine-restart = {
    enable = true;
    path = [ pkgs.nix ];
    wantedBy = [ "multi-user.target" ];
    serviceConfig = {
      Type = "oneshot";
      ExecStart = "systemctl --user restart gengar-engine.service";
    };
  };

  systemd.user.paths.gengar-engine-restart = {
    pathConfig = {
      PathModified = "/home/jon/github-runner-workspace/rust_target/release/engine";
    };
  };
}
