{ config, lib, pkgs, ... }:

{
  programs.fish = {
    enable = true;
    shellInit = builtins.readFile ./shell_init.fish;
    shellAbbrs = {
      vim = "nvim";
      e = "nvim";

      cb = "cargo build";
      ct = "cargo test";
      ctb = "cargo test build";
      cc = "cargo clippy";
      play = "nvim ~/workspace/play/play/src/main.rs";

      sp = "cargo sqlx prepare --workspace";
      sm = "cargo sqlx migrate run";

      gs = "git status";
      gl = "git ol";

      enix = "nvim ~/nixos/configuration.nix";
      unix = "sudo nixos-rebuild switch --flake ~/nixos";

      gss = "git push -u origin HEAD";
      gp = "git pull";
      gc = "git checkout";
      gco = "git commit";
      gcoa = "git commit --amend --no-edit";
      gcm = "git checkout master";
      ga = "git add";
      gds = "git diff --staged";
      yeet = "git push --force-with-lease";
      gfm = "git fetch origin master:master";
      grm = "git rebase master";
      gdab = "git branch | grep -v \"master\" | xargs git branch -D";

      dca = "docker kill (docker ps -q) && docker rm (docker ps -a -q) && docker volume rm (docker volume ls -q) && docker network prune -f";
      ds = "docker ps -a";
      dcu = "docker-compose up";
      dc = "docker-compose";
      drd = "docker run -e POSTGRES_PASSWORD=test123 -p 0.0.0.0:5432:5432 -d postgis/postgis:13-3.2-alpine";
      rmmigdb = "docker-compose kill migration-db && docker-compose rm migration-db -f";
      rmposdb = "docker-compose kill postgres && docker-compose rm postgres -f";
      rmdtdb = "docker kill postgres && docker rm postgres -f";

      tf = "terraform";

      l = "eza";
      ls = "eza";
      ll = "eza -l";
      lll = "eza -la";

      htop = "btm";
      top = "btm";
      du = "dust";
    };
  };
}
