mkdir -p ~/nixos-backup

if [ "$(ls -A ~/nixos-backup 2>/dev/null)" ]
then
  echo "Backup location already exists, wont copy current /etc/nixos as backup"
else
  echo "Backup location is empty, copying /etc/nixos as a backup"
  cp -r /etc/nixos/* ~/nixos-backup/
fi

mkdir -p ~/nixos/"$HOSTNAME"

if ! test -f ~/nixos/"$HOSTNAME"/hardware-configuration.nix; then
  echo "Copying hardware-configuration"
  cp ~/nixos-backup/hardware-configuration.nix ~/nixos/"$HOSTNAME"
fi

if [ ! -L /etc/nixos ]; then
  echo "Symbolic link does not exist, linking"
  sudo rm -rf /etc/nixos
  sudo ln -s ~/nixos /etc/nixos
fi

