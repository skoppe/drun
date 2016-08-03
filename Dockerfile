FROM greyltc/archlinux

MAINTAINER Sebastiaan Koppe <mail@skoppe.eu>

RUN pacman --noconfirm -Sy --force libevent && \
    # Clean up to make this as small as possible
    # Remove info, man and docs
    rm -r /usr/share/info/* && \

    # Delete any backup files like /etc/pacman.d/gnupg/pubring.gpg~
    find /. -name "*~" -type f -delete && \

    # Clean up pacman
    bash -c "echo 'y' | pacman -Scc >/dev/null 2>&1" && \
    paccache -rk0 >/dev/null 2>&1 &&  \
    pacman-optimize && \
    rm -r /var/lib/pacman/sync/*
