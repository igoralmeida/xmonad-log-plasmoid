# Xmonad Applet for KDE4 (Plasma)

This applet will print messages sent from XMonad's DBus-based logHook.
The default dynamicLog message will show the non-empty workspaces, layout name and window title. An example `xmonad.hs` file is provided for experimentation.

A similar implementation for the Gnome panel is [xmonad-log-applet](https://github.com/alexkay/xmonad-log-applet).

# Installation

  * Edit your xmonad.hs, see `xmonad.hs` for an example
  * In the root directory, run `make` and `make install`
  * Add the `xmonad-log-plasmoid` widget to the panel

# Known issues (patches/explanations welcome)

  * Removing and reinserting the widget crashes `plasma-desktop`. If this
    happens, just insert it again and it should work

# Acknowledgements

  * [Janx's work](https://github.com/janx/xmonad-log-plasmoid).
