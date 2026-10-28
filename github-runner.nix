{ pkgs, ... }:
{
  services.github-runners."kyogre" = {
    enable = true;
    user = "jon";
    group = "users";
    name = "onprem-datafangst";
    tokenFile = "/home/jon/secrets/github-runner-pat.token";
    url = "https://github.com/orcalabs";
    replace = true;
    extraPackages = with pkgs; [
      docker-compose
      docker
    ];
    serviceOverrides = {
      ReadWritePaths = [
        "/home/jon/secrets"
      ];
      ProtectHome = false;
    };
  };
}
