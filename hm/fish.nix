{
  programs.fish = {
    enable = true;
    loginShellInit = builtins.readFile ./login.fish;
    shellInit = builtins.readFile ./shell_init.fish;
    shellAbbrs = {
      vim = "nvim";
      e = "nvim";
      kav = "killall nvim";
      sinit = "sh ~/scripts/update_secrets.sh";

      ch = "cargo check";
      cb = "cargo build";
      ct = "cargo test";
      ctb = "cargo test build";
      cc = "cargo clippy";
      cr = "cargo run";
      crr = "cargo run --release";
      cbr = "cargo build --release";
      play = "nvim ~/workspace/play/play/src/main.rs";

      cd = "z";
      cat = "bat";

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
      gdab = "git branch | grep -v \"master\" | xargs git branch -D";
      gb = "git branch";
      gr = "git rebase";
      grc = "git rebase --continue";
      grm = "git rebase master";

      rsp = "systemctl --user restart pipewire.service";
      rsh = "bluetoothctl connect 78:2B:64:A0:5D:F9";

      volu = "wpctl set-volume @DEFAULT_SINK@ 0.05+";
      vold = "wpctl set-volume @DEFAULT_SINK@ 0.05-";
      volm = "set-mute @DEFAULT_SINK@ toggle";

      bru = "brightnessctl s +5%";
      brd = "brightnessctl s 5%-";

      dca = "docker kill (docker ps -q) && docker rm (docker ps -a -q) && docker volume rm (docker volume ls -q) && docker network prune -f";
      ds = "docker ps -a";
      dcu = "docker-compose up";
      dc = "docker-compose";
      drd = "docker run -e POSTGRES_PASSWORD=test123 -p 0.0.0.0:5432:5432 -d postgis/postgis:13-3.2-alpine";
      rsmigdb = "docker-compose kill migration-db && docker-compose rm migration-db -f && docker-compose up -d migration-db";
      rsposdb = "docker-compose kill postgres && docker-compose rm postgres -f && docker-compose up -d postgres";
      rsposdb2 = "docker-compose kill postgres2 && docker-compose rm postgres2 -f && docker-compose up -d postgres2";
      rmposdb = "docker-compose kill postgres && docker-compose rm postgres -f";
      rmdtdb = "docker kill postgres && docker rm postgres";

      tf = "terraform";
      tfp = "terraform plan";
      tfa = "terraform apply";

      ns = "nix-search";

      l = "eza";
      ls = "eza";
      ll = "eza -l";
      lll = "eza -la";

      htop = "btm";
      top = "btm";
      du = "dust";

      copy = "xclip -sel c";
      paste = "xclip -out -sel c";
    };
  };
}
