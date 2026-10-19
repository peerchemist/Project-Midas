# Project Midas Flatpak

This local build targets x86_64 Linux with Freedesktop Platform and SDK 26.08.
The game itself remains 32-bit, using the matching i386 compatibility and GL
extensions. It supports X11 (including XWayland), PulseAudio/PipeWire audio,
and game controllers. Device access includes the game's direct USB controller
support. Home-directory and network access are not enabled.

## Build

Install `flatpak` and `flatpak-builder` through your distribution, add Flathub,
and install the SDK and extensions:

```sh
flatpak install --user flathub org.freedesktop.Platform//26.08 \
  org.freedesktop.Sdk//26.08 org.freedesktop.Sdk.Compat.i386//26.08 \
  org.freedesktop.Sdk.Extension.toolchain-i386//26.08 \
  org.freedesktop.Platform.Compat.i386//26.08 \
  org.freedesktop.Platform.GL32.default//26.08
./scripts/build_flatpak.sh
```

Run the build script from the checkout containing `baserom.u.z64`. Its required
SHA-1 is `abe01e4aeb033b6c0836819f549c791b26cfde83`. Extraction and compilation
happen in `.flatpak-builder/`, leaving the source assets untouched. The output
is `ProjectMidas.flatpak`, with the local OSTree repository in `flatpak-repo/`.
The build uses the local working tree, including uncommitted changes; it does
not download the upstream project or the ROM. Flatpak Builder options may be
passed to the script, such as `--jobs=4`.

The bundle includes your verified ROM at `/app/share/midas/baserom.u.z64`
and loads it automatically. This is a personal package with game data.
License texts are included. ROM files and exported bundles remain untracked.

## Install and play

```sh
flatpak install --user ./ProjectMidas.flatpak
flatpak run io.github.peerchemist.ProjectMidas
```

The app also appears in the desktop launcher. No separate ROM setup is needed
on another machine. Flatpak installs the required runtime and extensions from
Flathub; those dependencies are separate from the application bundle.
An explicit `--rom-file` argument or `GE_ROM` environment variable can override
the bundled ROM.

New installations start in a decorated, resizable window. Alt+Enter toggles
fullscreen. Existing installations retain their settings; set
`fullscreen=windowed` under `[display]` in `midas.ini` for a decorated window.

Settings (`midas.ini`), `Data/Saves`, profiles, controller settings and logs
are all stored under:

```text
~/.var/app/io.github.peerchemist.ProjectMidas/data/midas/
```

Reinstalling the application preserves that directory. Controller defaults and
the base shader list refresh from the package on launch. The launcher sets
`GE_DATA_DIR` to this writable directory; ordinary unpackaged launches still
use the executable's directory.
