{ lib, config, ... }:
{
  wayland.windowManager.sway = {
    enable = true;
    package = null;
    xwayland = true;
    config = {
      modifier = "Mod4";
      terminal = "alacritty";
      menu = "noctalia-shell ipc call launcher toggle";
      # seat.seat0.xcursor_theme = "catppuccin-mocha-dark 18";
      output = {
        "*".bg = "/run/current-system/sw/share/backgrounds/sway/Sway_Wallpaper_Blue_1920x1080.png fill";
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
          "${modifier}+e" = "exec nautilus";
          "${modifier}+q" = "kill";
          "${modifier}+v" = "exec noctalia-shell ipc call launcher clipboard";
          "${modifier}+space" = "exec ${config.wayland.windowManager.sway.config.menu}";
          "XF86AudioMute" = "exec noctalia-shell ipc call volume muteOutput";
          "XF86AudioLowerVolume" = "exec noctalia-shell ipc call volume decrease";
          "XF86AudioRaiseVolume" = "exec noctalia-shell ipc call volume increase";
          "XF86MonBrightnessDown" = "exec noctalia-shell ipc call brightness decrease";
          "XF86MonBrightnessUp" = "exec noctalia-shell ipc call brightness increase";
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
    };
    extraConfig = ''
      default_border pixel 2

      blur enable
      blur_passes 2
      blur_radius 3

      corner_radius 20
      shadows enable
      shadow_blur_radius 4
      smart_corner_radius on

      bindgesture swipe:left workspace next
      bindgesture swipe:right workspace prev

      exec dbus-update-activation-environment --systemd DISPLAY WAYLAND_DISPLAY SWAYSOCK XDG_CURRENT_DESKTOP
      exec "systemctl --user import-environment {,WAYLAND_}DISPLAY SWAYSOCK; systemctl --user start sway-session.target"
      exec swaymsg -t subscribe '["shutdown"]' && systemctl --user stop sway-session.target

      include ~/.config/sway/noctalia
    '';
  };
}
