# Build context: scripts live in build_files/, branding assets in system_files/assets/
FROM scratch AS ctx
COPY build_files /
COPY system_files/assets /assets

# Homebrew — provides /usr/share/homebrew.tar.zst and brew-setup.service
# https://github.com/ublue-os/brew
FROM ghcr.io/ublue-os/brew:latest AS brew

# Base Image — Fedora Kinoite (KDE) with Universal Blue additions
FROM quay.io/fedora-ostree-desktops/kinoite:43

### Pre-install system configuration files
## Copied directly into the image before the build script runs.
## /etc: KDE/XDG config, hostname, skel
## /usr: Plasma themes, Plymouth config, ujust recipes, runtime install scripts
COPY system_files/etc /etc
COPY system_files/usr /usr

# Copy Homebrew archive and setup service from the brew stage
# Credit: https://github.com/ublue-os/brew contributors
COPY --from=brew /system_files /

### Build
## All package installation, kernel swap, branding, and plugin setup
## happens in build.sh. Scripts are at /ctx/, branding assets at /ctx/assets/.
RUN --mount=type=bind,from=ctx,source=/,target=/ctx \
    --mount=type=cache,dst=/var/cache \
    --mount=type=cache,dst=/var/log \
    --mount=type=tmpfs,dst=/tmp \
    --mount=type=tmpfs,dst=/run \
    /ctx/build.sh

### Lint
RUN bootc container lint
