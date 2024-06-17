{
  services.gnome.gnome-keyring.enable = true;
  programs.ssh.startAgent = true;

  programs.seahorse = {
    enable = true;
  };

  services.openssh = {
    enable = true;
    settings = {
      PasswordAuthentication = true;
    };
  };
}
