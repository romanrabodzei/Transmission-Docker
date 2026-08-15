#!/bin/sh
set -e

# Allow the container to run as an arbitrary host uid/gid so that bind-mounted
# /incompleted and /completed directories are writable regardless of what
# owns them on the host. Defaults match the debian-transmission system user.
PUID="${PUID:-100}"
PGID="${PGID:-101}"

if [ "$(id -u debian-transmission)" != "$PUID" ]; then
    usermod -o -u "$PUID" debian-transmission
fi

if [ "$(id -g debian-transmission)" != "$PGID" ]; then
    groupmod -o -g "$PGID" debian-transmission
fi

# Re-own the directories the daemon needs to write to. This runs on every
# start so it also repairs ownership after a bind mount swaps the underlying
# host directory.
chown -R debian-transmission:debian-transmission \
    /incompleted \
    /completed \
    /etc/transmission-daemon \
    /var/lib/transmission-daemon

# Hand off to the daemon in the foreground as PID 1 (via exec) so it
# receives signals directly and can shut down and save its state cleanly.
exec gosu debian-transmission:debian-transmission transmission-daemon --foreground --log-level=info
