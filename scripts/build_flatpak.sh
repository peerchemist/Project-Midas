#!/bin/bash
set -euo pipefail
cd "$(dirname "$0")/.."

command -v flatpak-builder >/dev/null
command -v flatpak >/dev/null
echo 'abe01e4aeb033b6c0836819f549c791b26cfde83  baserom.u.z64' | sha1sum -c -

flatpak-builder --user --force-clean --disable-rofiles-fuse \
    --repo=flatpak-repo build_flatpak \
    packaging/flatpak/io.github.peerchemist.ProjectMidas.json "$@"
flatpak build-bundle --runtime-repo=https://flathub.org/repo/flathub.flatpakrepo \
    flatpak-repo ProjectMidas.flatpak io.github.peerchemist.ProjectMidas
echo "Created $PWD/ProjectMidas.flatpak"
