{ lib, config, ... }:
{
  wayland.windowManager.sway = {
    enable = true;
    package = null;
    xwayland = true;
    config = {
      bars = [ ];
      modifier = "Mod4";
      terminal = "alacritty";
      # seat.seat0.xcursor_theme = "catppuccin-mocha-dark 18"; #Cursor theme
      output = {
        eDP-1 = {
          mode = "1920x1080@144.002Hz";
          scale = "1.2";
          adaptive_sync = "on";
        };
      };
      input = {
        "type:touchpad" = {
          dwt = "enabled";
          tap = "enabled";
          natural_scroll = "enabled";
          middle_emulation = "enabled";
        };
        "type:keyboard" = {
          xkb_layout = "eu";
          xkb_numlock = "enabled";
        };
        "type:pointer" = {
          accel_profile = "flat";
        };
      };
      keybindings =
        let
          modifier = config.wayland.windowManager.sway.config.modifier;
        in
        lib.mkOptionDefault {
          "${modifier}+0" = null;
          "${modifier}+e" = "exec nautilus";
          "${modifier}+q" = "kill";
          "${modifier}+v" = "exec $ipc panel-toggle clipboard";
          "${modifier}+space" = "exec $ipc panel-toggle launcher";
          "XF86AudioMute" = "exec $ipc volume-mute";
          "XF86AudioLowerVolume" = "exec $ipc volume-down";
          "XF86AudioRaiseVolume" = "exec $ipc volume-up";
          "XF86MonBrightnessDown" = "exec $ipc brightness-down";
          "XF86MonBrightnessUp" = "exec $ipc brightness-up";
          "Print" = "exec grimshot savecopy area";
        };
      gaps = {
        inner = 5;
        outer = 10;
      };
      startup = [
        { command = "hyprlock"; }
        { command = "noctalia-shell"; }
        { command = "wl-paste --watch cliphist store"; }
      ];
      window = {
        border = 2;
        titlebar = false;
      };
    };
    extraConfig = ''
      set $ipc noctalia msg
      
      blur enable
      blur_passes 2
      blur_radius 3

      corner_radius 20
      shadows enable
      shadow_blur_radius 4
      smart_corner_radius on

      bindgesture swipe:left workspace next
      bindgesture swipe:right workspace prev

      include ~/.config/sway/noctalia
    '';
  };
}
