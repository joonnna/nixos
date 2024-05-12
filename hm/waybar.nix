{

  programs.eww = {
    enable = true;
    configDir = ./eww_config;
  };

  # {
  # cargoBuildFlags = [
  #   "--bin"
  #   "eww"
  #   "--no-default-features"
  #   "--features=wayland"
  # ];
  # };

  # programs.waybar = {
  #   enable = true;
  #   systemd = {
  #     enable = true;
  #   };

  #   settings =
  #     {
  #       mainBar = {
  #         layer = "top";
  #         position = "top";
  #         height = 30;
  #         # output = [
  #         #   "eDP-1"
  #         #   "HDMI-A-1"
  #         # ];
  #         modules-center = [ "hyprland/workspaces" ];

  #         # "sway/workspaces" = {
  #         #   disable-scroll = true;
  #         #   all-outputs = true;
  #         # };

  #         "hyprland/workspaces" = {
  #           format = "{icon}";
  #           on-scroll-up = "hyprctl dispatch workspace e+1";
  #           on-scroll-down = "hyprctl dispatch workspace e-1";
  #         };
  #       };
  #     };
  # };
}
