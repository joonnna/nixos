{
  services.gnome.gnome-keyring.enable = true;
  # programs.ssh.startAgent = true;

  # Need to enable 1password to store 2FA code on unlock,
  # think this is due to keyring being locked when without this
  # enabled which I think unlocks the keyring on login
  # through lightdm (login prompt)
  # For the onpremise work node a login needs to occur on the actual physical node to unlock
  # the keyring through lightdm.
  # If there only exists a SSH session 1password will be unable to unlock the keyring and
  # will need a 2FA code.
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
