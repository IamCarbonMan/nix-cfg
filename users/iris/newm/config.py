import os
from pywm import (
    PYWM_MOD_LOGO,
    PYWM_MOD_ALT
)

outputs = [
    {'name':'eDP-1'},
    {'name':'HDMI-1'}
]

background = {
    'path': os.environ['HOME'] + '/wallpaper.png'
}

def on_startup():
    os.system("systemctl --user import-environment DISPLAY WAYLAND_DISPLAY XDG_CURRENT_DESKTOP")
    os.system("hash dbus-update-activation-environment 2>/dev/null && \
        dbus-update-activation-environment --systemd DISPLAY \
        WAYLAND_DISPLAY XDG_CURRENT_DESKTOP")

def key_bindings(layout):
    return [
        ("L-Left", lambda: layout.move(-1, 0)),
        ("L-Up", lambda: layout.move(0, 1)),
        ("L-Down", lambda: layout.move(0, -1)),
        ("L-Right", lambda: layout.move(1, 0)),
        ("L-S-Left", lambda: layout.move_focused_view(-1, 0)),
        ("L-S-Up", lambda: layout.move_focused_view(0, 1)),
        ("L-S-Down", lambda: layout.move_focused_view(0, -1)),
        ("L-S-Right", lambda: layout.move_focused_view(1, 0)),
        ("L-C-Left", lambda: layout.resize_focused_view(-1, 0)),
        ("L-C-Up", lambda: layout.resize_focused_view(0, 1)),
        ("L-C-Down", lambda: layout.resize_focused_view(0, -1)),
        ("L-C-Right", lambda: layout.resize_focused_view(1, 0)),
        ("L-Return", lambda: os.system("kitty &")),
        ("L-Space", lambda: layout.enter_launcher_overlay()),
        ("L-q", lambda: layout.close_focused_view()),
        ("L-S-Esc", lambda: layout.update_config()),
        ("L-f", lambda: layout.toggle_fullscreen()),
        ("L-", lambda: layout.toggle_overview())
    ]

panels = {}

