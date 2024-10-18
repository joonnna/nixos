{ pkgs, ... }:

{

  services.github-runners."gengar" = {
    enable = true;
    user = "jon";
    group = "users";
    name = "local-live-game-streamer";
    tokenFile = "/home/jon/github-runner-pat.token";
    url = "https://github.com/orcalabs/gengar";
    replace = true;
    extraLabels = [ "gengar-gpu" ];
    workDir = "/home/jon/github-runner-workspace/repos";
    serviceOverrides = {
      ReadWritePaths = [
        "/home/jon/github-runner-workspace"
      ];
      ProtectHome = false;
      ProtectUsers = false;
    };
    extraEnvironment = {
      CUSTOM_RUNNER_ROOT = "/home/jon/github-runner-workspace";
      CUSTOM_RUNNER_WORK_DIR = "$CUSTOM_RUNNER_ROOT/repos";
      SECRETS_PATH = "/home/jon/secrets";
    };
  };


  systemd.user.services.gengar-engine-re = {
    enable = true;
    path = [ pkgs.nix ];
    script = ''
      nix-shell "$CUSTOM_RUNNER_ROOT/shell.nix" --command "$CUSTOM_RUNNER_ROOT/rust_target/release/engine"
    '';
    wantedBy = [ "default.target" ];
    serviceConfig = {
      Restart = "always";
      RestartSec = 30;
    };
    environment = {
      CUSTOM_RUNNER_ROOT = "/home/jon/github-runner-workspace";
      CUSTOM_RUNNER_WORK_DIR = "$CUSTOM_RUNNER_ROOT/repos";
      SECRETS_PATH = "/home/jon/secrets";
      NIX_PATH = "/etc/nix/path";
      SQLX_OFFLINE = "true";
    };
  };

  systemd.user.services.gengar-engine-restart-re = {
    enable = true;
    path = [ pkgs.nix ];
    wantedBy = [ "default.target" ];
    serviceConfig = {
      Type = "oneshot";
      ExecStart = "systemctl --user restart gengar-engine-re.service";
    };
  };

  systemd.user.paths.gengar-engine-restart-re = {
    enable = true;
    wantedBy = [ "default.target" ];
    pathConfig = {
      PathModified = "/home/jon/github-runner-workspace/rust_target/release/engine";
    };
  };
}
