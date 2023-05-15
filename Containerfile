FROM docker.io/library/archlinux:base-devel

LABEL com.github.containers.toolbox="true" \
      name="archbox" \
      version="base-devel" \
      usage="For use with distrobox" \
      summary="Customized image for Arch Linux in Distrobox" \
      maintainer="dan@danielproctor.dev"

COPY files/tmp /tmp
WORKDIR /tmp

# install packages
RUN pacman -Syu --needed --noconfirm - < /tmp/packages

# install yay
RUN git clone https://aur.archlinux.org/yay-bin.git && \
      chown -R user:user ./yay-bin && \
      cd yay-bin && \
      makepkg -si

# setup host-exec
RUN chmod u+x /tmp/host-exec.sh
RUN /tmp/host-exec.sh

# cleanup
RUN rm -rf /tmp/*

# Clean up cache
RUN pacman -Scc --noconfirm

# Enable sudo permission for wheel users
RUN echo "%wheel ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/toolbox
