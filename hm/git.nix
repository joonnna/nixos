{
  programs.git = {
    enable = true;
    settings = {
      user = {
        name = "joonnna";
        email = "jonfossmikalsen1@gmail.com";
      };
      aliases = {
        ol = "log --oneline --format='%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset'";
      };
      diff = {
        external = "difft";
      };
      pull = {
        ff = "only";
      };
      credential = {
        helper = "store";
      };
    };
  };
}
