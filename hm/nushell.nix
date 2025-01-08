{ ... }:

{
  programs = {
    nushell = {
      enable = true;
      extraConfig = ''
        $env.PATH = ($env.PATH |
        split row (char esep) |
        prepend /home/jon/.apps |
        append /usr/bin/env
        )

        edit_mode = "vi";
      '';
    };
  };
}
