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
      testing = "nvim ~/workspace/testing/src/main.rs";

      sp = "cargo sqlx prepare -- --lib";
      sm = "sqlx migrate run";

      gs = "git status";
      gl = "git ol";

      gss = "git push -u origin HEAD";
      gp = "git push";
      gds = "git diff --staged";
      yeet = "git push --force-with-lease";
      gfm = "git fetch origin master:master";
      grm = "git rebase master";
      gdab = "git branch | grep -v \"master\" | xargs git branch -D";

      dca = "docker kill (docker ps -q) && docker rm (docker ps -a -q) && docker volume rm (docker volume ls -q) && docker network prune -f";
      ds = "docker ps -a";
      dr = "docker rm";
      dk = "docker kill";
      drd = "docker run -e POSTGRES_PASSWORD=test123 -p 0.0.0.0:5432:5432 -d postgis/postgis:13-3.2-alpine";

      so4 = "TERM=xterm ssh orca@192.168.38.13";
      so3 = "TERM=xterm ssh orca@192.168.38.12";
      so2 = "TERM=xterm ssh orca@192.168.38.11";
      so1 = "TERM=xterm ssh orca@192.168.38.10";

      l = "exa";
      ls = "exa";
      ll = "exa -l";
      lll = "exa -la";

      htop = "btm";
      top = "btm";
    };
    plugins = [
      {
        name = "pure";
        src = pkgs.fishPlugins.pure.src;
      }
    ];
  };
}
