{ lib, ... }:
{
  wayland.windowManager.hyprland = {
    enable = true;
    package = null;
    portalPackage = null;
    systemd.enable = false;
    configType = "lua";
    settings = {
      monitor = {
        output = "";
        mode = "1920x1080@144";
        position = "auto";
        scale = "1.25";
      };
      gesture = {
        fingers = 3;
        direction = "horizontal";
        action = "workspace";
      };
      config = {
        input = {
          kb_layout = "us";
          numlock_by_default = true;
          follow_mouse = 1;
          sensitivity = 0;
          accel_profile = "flat";
          touchpad.natural_scroll = true;
        };
        xwayland = {
          force_zero_scaling = true;
        };
        general = {
          gaps_in = 5;
          gaps_out = 10;
          border_size = 2;
          col = {
            active_border = "0xffeb6f92";
            inactive_border = "0xff31748f";
          };
          layout = "dwindle";
        };
        dwindle = {
          preserve_split = true;
        };
        decoration = {
          rounding = 20;
          rounding_power = 2;
          shadow = {
            enabled = true;
            range = 4;
            render_power = 3;
            color = "rgba(1a1a1aee)";
          };
          blur = {
            enabled = true;
            size = 3;
            passes = 1;
            vibrancy = 0.1696;
          };
        };
        animations = {
          enabled = true;
        };
        misc = {
          vrr = 1;
        };
      };
      curve = [
        {
          _args = [
            "expressiveFastSpatial"
            {
              type = "bezier";
              points = lib.generators.mkLuaInline "{ { 0.42, 1.67 }, { 0.21, 0.90 } }";
            }
          ];
        }
        {
          _args = [
            "expressiveSlowSpatial"
            {
              type = "bezier";
              points = lib.generators.mkLuaInline "{ { 0.39, 1.29 }, { 0.35, 0.98 } }";
            }
          ];
        }
        {
          _args = [
            "expressiveDefaultSpatial"
            {
              type = "bezier";
              points = lib.generators.mkLuaInline "{ { 0.38, 1.21 }, { 0.22, 1.00 } }";
            }
          ];
        }
        {
          _args = [
            "emphasizedDecel"
            {
              type = "bezier";
              points = lib.generators.mkLuaInline "{ { 0.05, 0.7 }, {0.1, 1 } }";
            }
          ];
        }
        {
          _args = [
            "emphasizedAccel"
            {
              type = "bezier";
              points = lib.generators.mkLuaInline "{ { 0.3, 0 }, { 0.8, 0.15 } }";
            }
          ];
        }
        {
          _args = [
            "standardDecel"
            {
              type = "bezier";
              points = lib.generators.mkLuaInline "{ { 0, 0 }, { 0.8, 0.15 } }";
            }
          ];
        }
        {
          _args = [
            "menu_decel"
            {
              type = "bezier";
              points = lib.generators.mkLuaInline "{ { 0.1, 1 }, { 0, 1 } }";
            }
          ];
        }
        {
          _args = [
            "menu_accel"
            {
              type = "bezier";
              points = lib.generators.mkLuaInline "{ { 0.52, 0.03 }, { 0.72, 0.08 } }";
            }
          ];
        }
        {
          _args = [
            "stall"
            {
              type = "bezier";
              points = lib.generators.mkLuaInline "{ { 1, -0.1 }, { 0.7, 0.85 } }";
            }
          ];
        }
      ];
      animation = [
        {
          leaf = "windowsIn";
          enabled = true;
          speed = 3;
          bezier = "emphasizedDecel";
          style = "popin 80%";
        }
        {
          leaf = "fadeIn";
          enabled = true;
          speed = 3;
          bezier = "emphasizedDecel";
        }
        {
          leaf = "windowsOut";
          enabled = true;
          speed = 2;
          bezier = "emphasizedDecel";
          style = "popin 90%";
        }
        {
          leaf = "fadeOut";
          enabled = true;
          speed = 2;
          bezier = "emphasizedDecel";
        }
        {
          leaf = "windowsMove";
          enabled = true;
          speed = 3;
          bezier = "emphasizedDecel";
          style = "slide";
        }
        {
          leaf = "layersIn";
          enabled = true;
          speed = 2.7;
          bezier = "emphasizedDecel";
          style = "popin 93%";
        }
        {
          leaf = "layersOut";
          enabled = true;
          speed = 2.4;
          bezier = "menu_accel";
          style = "popin 94%";
        }
        {
          leaf = "fadeLayersIn";
          enabled = true;
          speed = 0.5;
          bezier = "menu_decel";
        }
        {
          leaf = "fadeLayersOut";
          enabled = true;
          speed = 2.7;
          bezier = "stall";
        }
        {
          leaf = "workspaces";
          enabled = true;
          speed = 7;
          bezier = "menu_decel";
          style = "slide";
        }
        {
          leaf = "specialWorkspaceIn";
          enabled = true;
          speed = 2.8;
          bezier = "emphasizedDecel";
          style = "slidevert";
        }
        {
          leaf = "specialWorkspaceOut";
          enabled = true;
          speed = 1.2;
          bezier = "emphasizedAccel";
          style = "slidevert";
        }
        {
          leaf = "zoomFactor";
          enabled = true;
          speed = 3;
          bezier = "standardDecel";
        }
      ];
      layer_rule = {
        name = "noctalia";
        match.namespace = "noctalia-background-.*$";
        ignore_alpha = 0.5;
        blur = true;
        blur_popups = true;
      };
      window_rule = [
        {
          name = "suppress-maximize-events";
          match.class = ".*";
          suppress_event = "maximize";
        }
      ];
      on = {
        _args = [
          "hyprland.start"
          (lib.generators.mkLuaInline ''
            function()
              hl.exec_cmd("hyprlock")
              hl.exec_cmd("noctalia-shell")
              hl.exec_cmd("hyprctl setcursor catppuccin-mocha-dark 16")
              hl.exec_cmd("wl-paste --watch cliphist store")
            end
          '')
        ];
      };
      bind = [
        {
          _args = [
            "SUPER + RETURN"
            (lib.generators.mkLuaInline ''hl.dsp.exec_cmd("alacritty")'')
          ];
        }
        {
          _args = [
            "SUPER + E"
            (lib.generators.mkLuaInline ''hl.dsp.exec_cmd("nautilus")'')
          ];
        }
        {
          _args = [
            "SUPER + Q"
            (lib.generators.mkLuaInline "hl.dsp.window.close()")
          ];
        }
        {
          _args = [
            "SUPER + V"
            (lib.generators.mkLuaInline ''hl.dsp.exec_cmd("noctalia-shell ipc call launcher clipboard")'')
          ];
        }
        {
          _args = [
            "SUPER + SPACE"
            (lib.generators.mkLuaInline ''hl.dsp.exec_cmd("noctalia-shell ipc call launcher toggle")'')
          ];
        }
        {
          _args = [
            "XF86AudioMute"
            (lib.generators.mkLuaInline ''hl.dsp.exec_cmd("noctalia-shell ipc call volume muteOutput")'')
          ];
        }
        {
          _args = [
            "XF86AudioLowerVolume"
            (lib.generators.mkLuaInline ''hl.dsp.exec_cmd("noctalia-shell ipc call volume decrease")'')
          ];
        }
        {
          _args = [
            "XF86AudioRaiseVolume"
            (lib.generators.mkLuaInline ''hl.dsp.exec_cmd("noctalia-shell ipc call volume increase")'')
          ];
        }
        {
          _args = [
            "XF86MonBrightnessDown"
            (lib.generators.mkLuaInline ''hl.dsp.exec_cmd("noctalia-shell ipc call brightness decrease")'')
          ];
        }
        {
          _args = [
            "XF86MonBrightnessUp"
            (lib.generators.mkLuaInline ''hl.dsp.exec_cmd("noctalia-shell ipc call brightness increase")'')
          ];
        }
        {
          _args = [
            "Print"
            (lib.generators.mkLuaInline ''hl.dsp.exec_cmd("grimshot savecopy area")'')
          ];
        }
        {
          _args = [
            "SUPER + SHIFT + SPACE"
            (lib.generators.mkLuaInline ''hl.dsp.window.float({ action = "toggle" })'')
          ];
        }
        {
          _args = [
            "SUPER + left"
            (lib.generators.mkLuaInline ''hl.dsp.focus({ direction = "left" })'')
          ];
        }
        {
          _args = [
            "SUPER + right"
            (lib.generators.mkLuaInline ''hl.dsp.focus({ direction = "right" })'')
          ];
        }
        {
          _args = [
            "SUPER + up"
            (lib.generators.mkLuaInline ''hl.dsp.focus({ direction = "up" })'')
          ];
        }
        {
          _args = [
            "SUPER + down"
            (lib.generators.mkLuaInline ''hl.dsp.focus({ direction = "down" })'')
          ];
        }
        {
          _args = [
            "SUPER + H"
            (lib.generators.mkLuaInline ''hl.dsp.focus({ direction = "left" })'')
          ];
        }
        {
          _args = [
            "SUPER + J"
            (lib.generators.mkLuaInline ''hl.dsp.focus({ direction = "down" })'')
          ];
        }
        {
          _args = [
            "SUPER + K"
            (lib.generators.mkLuaInline ''hl.dsp.focus({ direction = "up" })'')
          ];
        }
        {
          _args = [
            "SUPER + L"
            (lib.generators.mkLuaInline ''hl.dsp.focus({ direction = "right" })'')
          ];
        }
        {
          _args = [
            "SUPER + SHIFT + H"
            (lib.generators.mkLuaInline ''hl.dsp.window.move({ direction = "left" })'')
          ];
        }
        {
          _args = [
            "SUPER + SHIFT + J"
            (lib.generators.mkLuaInline ''hl.dsp.window.move({ direction = "down" })'')
          ];
        }
        {
          _args = [
            "SUPER + SHIFT + K"
            (lib.generators.mkLuaInline ''hl.dsp.window.move({ direction = "up" })'')
          ];
        }
        {
          _args = [
            "SUPER + SHIFT + L"
            (lib.generators.mkLuaInline ''hl.dsp.window.move({ direction = "right" })'')
          ];
        }
        {
          _args = [
            "SUPER + S"
            (lib.generators.mkLuaInline ''hl.dsp.workspace.toggle_special("magic")'')
          ];
        }
        {
          _args = [
            "SUPER + SHIFT + S"
            (lib.generators.mkLuaInline ''hl.dsp.window.move({ workspace = "special:magic" })'')
          ];
        }
        {
          _args = [
            "SUPER + mouse:272"
            (lib.generators.mkLuaInline "hl.dsp.window.drag()")
            { mouse = true; }
          ];
        }
        {
          _args = [
            "SUPER + mouse:273"
            (lib.generators.mkLuaInline "hl.dsp.window.resize()")
            { mouse = true; }
          ];
        }
      ]
      ++ (lib.concatLists (
        lib.genList (
          i:
          let
            ws = i + 1;
          in
          [
            {
              _args = [
                "SUPER + ${toString ws}"
                (lib.generators.mkLuaInline "hl.dsp.focus({ workspace = ${toString ws} })")
              ];
            }
            {
              _args = [
                "SUPER + SHIFT + ${toString ws}"
                (lib.generators.mkLuaInline "hl.dsp.window.move({ workspace = ${toString ws} })")
              ];
            }
          ]
        ) 9
      ));
    };
    extraConfig = ''
      dofile(os.getenv("HOME") .. "/.config/hypr/noctalia/noctalia-colors.lua")
    '';
  };

  xdg.configFile = {
    "uwsm/env".text = ''
      export GDK_BACKEND="wayland,x11,*"
      export QT_QPA_PLATFORM="wayland;xcb"
      export SDL_VIDEODRIVER="wayland"

      export GTK_THEME="adw-gtk3"
      export XCURSOR_THEME=catppuccin-mocha-dark
      export XCURSOR_SIZE=16
    '';
    "uwsm/env-hyprland".text = ''
      export AQ_DRM_DEVICES="/dev/dri/by-name/igpu"
    '';
  };
}
