{ config, pkgs, ... }:

{
  home.packages = with pkgs; [ hyprlock hypridle ];

  xdg.configFile."hypr/hyprlock.conf".text = ''
    background {
      monitor = eDP-1
      blur_size = 8
      blur_passes = 3
      contrast = 0.9
      brightness = 0.8
    }

    general {
      disable_loading_bar = false
      grace = 0
    }

    input-field {
      monitor = eDP-1
      size = 200, 40
      position = 0, -200
      halign = center
      valign = center
      font_color = rgb(76,79,105)
      inner_color = rgb(239,241,245)
      outer_color = rgb(220,138,120)
      outline_thickness = 2
    }
  '';

    xdg.configFile."hypr/hypridle.conf".text = ''
      general {
        lock_cmd = ${pkgs.hyprlock}/bin/hyprlock
        before_sleep_cmd = ${pkgs.hyprlock}/bin/hyprlock
        after_sleep_cmd = ${pkgs.hyprlock}/bin/hyprlock
      }
   
      listener {
        timeout = 300
        on-timeout = ${pkgs.hyprlock}/bin/hyprlock
      }
   
      listener {
        timeout = 600
        on-timeout = systemctl suspend
      }
    '';
}

