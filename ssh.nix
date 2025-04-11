{
  services.gnome.gnome-keyring.enable = true;
  programs.ssh.startAgent = true;

  # Need to enable 1password to store 2FA code on unlock,
  # think this is due to keyring being locked when without this
  # enabled which I think unlocks the keyring on login
  # through lightdm (login prompt)
  security.pam.services.lightdm.enableGnomeKeyring = true;

  services.openssh = {
    enable = true;
    settings = {
      PasswordAuthentication = true;
      X11Forwarding = true;
      X11UseLocalhost = false;
    };
  };
}
