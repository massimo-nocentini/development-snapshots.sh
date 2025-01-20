sudo pacman -S --needed base-devel git
sudo pacman -S llvm clang openmp
sudo pacman -S vim piper rlwrap gnome-tweaks awesome-terminal-fonts discord mupdf mupdf-tools mpv
sudo pacman -S curl wget cairo pango poppler libgit2 libssh2 libtool tree-sitter tree-sitter-cli nodejs gdk-pixbuf2 gtk4 glib2-devel
sudo pacman -S sdl2 sdl2_gfx sdl2_image sdl2_mixer sdl2_net sdl2_ttf


# for activating services
sudo systemctl enable gdm.service
sudo systemctl start gdm.service
sudo systemctl enable bluetooth.service
sudo systemctl start bluetooth.service
