{
  programs.waybar = {
    enable = true;
    systemd = {
      enable = true;
    };
    style = ''
      * {
          border: none;
          font-family: Isoevka;
          font-size: 12px;
          color: #ffffff;
          border-radius: 20px;
      }
      window#waybar {
          margin: 0;
          padding: 0;
          background: rgba(0, 0, 0, 0);
      }

      .modules-center {
          margin: 2px 0 0 5px;
          background-color: rgba(0,119,179,0.6);
      }

      #workspaces button.active {
        background-color: rgba(0,43,51,0.85);
      }
    '';

    settings =
      {
        mainBar = {
          layer = "top";
          position = "top";
          height = 30;
          # output = [
          #   "eDP-1"
          #   "HDMI-A-1"
          # ];
          modules-center = [ "hyprland/workspaces" ];
          "hyprland/workspaces" = {
            format = "{icon}";
            on-scroll-up = "hyprctl dispatch workspace e+1";
            on-scroll-down = "hyprctl dispatch workspace e-1";
          };

        };
      };
  };
}
