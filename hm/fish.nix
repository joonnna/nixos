{
  programs.fish = {
    enable = true;
    loginShellInit = builtins.readFile ./login.fish;
    shellInit = builtins.readFile ./shell_init.fish;
    shellAbbrs = {
      vim = "nvim";
      e = "nvim";
      kav = "killall nvim";

      c = "cargo";

      ct = "cargo test";
      cth = "cargo test check";
      ctb = "cargo test build";

      cb = "cargo build";
      cbr = "cargo build --release";

      cr = "cargo run";
      crr = "cargo run --release";

      ch = "cargo check";
      cc = "cargo clippy";

      cdk = "cd ~/workspace/kyogre";
      cdg = "cd ~/workspace/gengar";
      cdo = "cd ~/workspace/orcastrator";
      cdn = "cd ~/nixos";
      cdi = "cd ~/workspace/infrastructure";

      play = "nvim ~/workspace/play/play/src/main.rs";

      cat = "bat";

      rf = "rainfrog";
      rfgl = "rainfrog --url postgresql://postgres:test123@127.0.0.1:5432";
      rfgm = "rainfrog --url postgresql://postgres:test123@127.0.0.1:5433";
      rfgt = "rainfrog --url postgresql://postgres:test123@127.0.0.1:5434";
      rfgd = "rainfrog --url postgresql://postgres:$DB_PASSWORD@orca-postgres-dev.postgres.database.azure.com:5432/gengar_dev";

      rfkl = "rainfrog --url postgresql://postgres:test123@127.0.0.1:5532";
      rfkm = "rainfrog --url postgresql://postgres:test123@127.0.0.1:5533";
      rfkt = "rainfrog --url postgresql://postgres:test123@127.0.0.1:5534";
      rfkd = "rainfrog --url postgresql://postgres:$DB_PASSWORD@orca-postgres-dev.postgres.database.azure.com:5432/kyogre";

      sp = "cargo sqlx prepare --workspace";
      sm = "cargo sqlx migrate run";

      enix = "nvim ~/nixos/configuration.nix";
      unix = "sudo nixos-rebuild switch --flake ~/nixos";


      gs = "git status";
      gst = "git stash";
      gsp = "git stash pop";

      gc = "git checkout";
      gcm = "git checkout master";
      gco = "git commit";
      gcoa = "git commit --amend";
      gcoan = "git commit --amend --no-edit";

      gp = "git pull";
      gpr = "git pull --rebase";
      gpu = "git push";
      gpun = "git push -u origin HEAD";

      gr = "git rebase";
      grc = "git rebase --continue";
      grm = "git rebase master";

      gb = "git branch";
      gbr = "git branch -m ";
      gdab = "git branch | grep -v \"master\" | xargs git branch -D";

      gf = "git fetch";
      gfm = "git fetch origin master:master";

      gd = "git diff";
      gds = "git diff --staged";

      gl = "git ol";
      ga = "git add";
      yeet = "git push --force-with-lease";

      ghrc = "gh repo clone";
      ghrn = "gh repo create --clone";

      rsp = "systemctl --user restart pipewire.service";

      bch = "bluetoothctl connect 78:2B:64:A0:5D:F9";
      bck = "bluetoothctl connect FE:64:7E:54:D9:C6";

      volu = "wpctl set-volume @DEFAULT_SINK@ 0.05+";
      vold = "wpctl set-volume @DEFAULT_SINK@ 0.05-";
      volm = "set-mute @DEFAULT_SINK@ toggle";

      bru = "brightnessctl s +5%";
      brd = "brightnessctl s 5%-";

      d = "docker";

      ds = "docker ps -a";

      dc = "docker-compose";
      dcu = "docker-compose up";
      dcud = "docker-compose up -d";
      dcd = "docker-compose down";

      dl = "docker logs";
      dlf = "docker logs -f ";

      dp = "docker prune";
      dpc = "docker container prune -f";
      dpv = "docker volume prune -f";
      dpn = "docker network prune -f";

      dka = "docker kill (docker ps -q)";

      dnuke = "docker kill (docker ps -q) && docker container prune -f && docker volume prune -f && docker network prune -f";

      rsmdb = "docker-compose kill migration-db && docker-compose rm migration-db -f && docker-compose up -d migration-db";
      rsldb = "docker-compose kill postgres && docker-compose rm postgres -f && docker-compose up -d postgres";

      rmldb = "docker-compose kill postgres && docker-compose rm postgres -f";
      rmtdb = "docker kill postgres && docker rm postgres";

      tf = "terraform";
      tfp = "terraform plan";
      tfa = "terraform apply";
      tfi = "terraform init";

      ns = "nix-search";

      l = "eza";
      ls = "eza";
      ll = "eza -l";
      lll = "eza -la";

      htop = "btm";
      top = "btm";
      du = "dust";

      copy = "wl-copy";
      paste = "wl-paste";
    };
  };
}
