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
}
