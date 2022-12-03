{ config, lib, pkgs, ... }:

{
  programs.git = {
    enable = true;
    userName = "joonnna";
    userEmail = "jonfossmikalsen1@gmail.com";
    aliases = {
      ol = "log --oneline --format='%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset'";
    };
    extraConfig = {
      pull = {
        ff = "only";
      };
      credential = {
        helper = "store";
      };
    };
  };

  xdg.configFile."git/credentials".text = ''
    https://jon-foss-mikalsen:0ebaa8eecc59492436e8012fe38fce24e4961518@dl.cloudsmith.io
  '';
}
