
# Change the following line in /etc/default/grub:
# GRUB_CMDLINE_LINUX_DEFAULT="quiet video=DSI-1:panel_orientation=right_side_up"
# to enable correct coordinates for the pen too. Then, sudo update-grub.

safe:
	echo "Safe rule to avoid unwanted compilations"

system:
	sudo apt update
	sudo apt upgrade
	sudo apt install build-essential gitg libgit2-dev rlwrap cmake \
		libpango-1.0-0 libpangocairo-1.0-0 libpango1.0-dev fontconfig libfontconfig-dev libglib2.0-0 \
		synaptic libfuse2 libstdc++-13-dev gcc-13-x86-64-linux-gnux32 flatpak piper \
		curl libcurl4 libcurl4-gnutls-dev filezilla gedit libpoppler-dev libpoppler-glib-dev gnome-tweaks \
		libgit2-1.5 libcrypto++8 libgit2-glib-1.0-dev librsvg2-dev libgtk-4-dev gnome-boxes

flatpak:
	flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo

google-chrome:
	mkdir -p snapshots/google-chrome
	cd snapshots/google-chrome \
		&& wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb \
		&& sudo dpkg -i google-chrome-stable_current_amd64.deb 

firefox:
	mkdir -p snapshots/firefox
	cd snapshots/firefox \
		&& wget https://download-installer.cdn.mozilla.net/pub/firefox/releases/117.0.1/linux-x86_64/en-US/firefox-117.0.1.tar.bz2 \
		&& tar xfj firefox-117.0.1.tar.bz2

code:
	mkdir -p snapshots/code
	cd snapshots/code \
		&& wget https://az764295.vo.msecnd.net/stable/695af097c7bd098fbf017ce3ac85e09bbc5dda06/code_1.79.2-1686734195_amd64.deb \
		&& sudo dpkg -i code_1.79.2-1686734195_amd64.deb

python:
	sudo apt build-dep python3.11
	mkdir -p snapshots/python \
		&& cd snapshots/python \
		&& wget https://www.python.org/ftp/python/3.11.4/Python-3.11.4.tar.xz \
		&& tar xfJ Python-3.11.4.tar.xz \
		&& cd Python-3.11.4 \
		&& ./configure --enable-optimizations --with-ensurepip && make -j4 && sudo make install
		#&& cd .. && sudo rm -rf Python-3.11.4

vim:
	mkdir -p snapshots/vim \
		&& cd snapshots/vim \
		&& wget https://github.com/vim/vim/archive/refs/tags/v9.0.1672.tar.gz \
		&& tar xfz v9.0.1672.tar.gz \
		&& cd vim-9.0.1672 \
		&& ./configure && make && sudo make install \
		&& cd .. && rm -rf vim-9.0.1672 

lua:
	# From: https://blog.spreendigital.de/2020/05/24/how-to-compile-lua-5-4-0-for-linux-as-a-shared-library/
	mkdir -p snapshots/lua \
		&& cd snapshots/lua \
		&& wget https://www.lua.org/ftp/lua-5.4.6.tar.gz \
		&& tar xfz lua-5.4.6.tar.gz \
		&& cd lua-5.4.6 \
		&& patch src/Makefile < ../../../lua-src-Makefile.patch \
		&& patch Makefile < ../../../lua-Makefile.patch \
		&& make "MYCFLAGS=-fPIC" "R=5.4.6" linux-readline && sudo make install

today := `date +'%Y%m%d'`

texlive:
	mkdir -p snapshots/texlive \
		&& cd snapshots/texlive \
		&& wget https://mirror.ctan.org/systems/texlive/tlnet/install-tl-unx.tar.gz \
		&& tar xfz install-tl-unx.tar.gz \
		&& cd install-tl-$(today) \
		&& sudo ./install-tl \
		&& cd .. && rm -rf install-tl-$(today)

pgsql:
	sudo apt build-dep postgresql-15
	mkdir -p snapshots/pgsql
	cd snapshots/pgsql \
		&& wget https://ftp.postgresql.org/pub/source/v16.0/postgresql-16.0.tar.gz \
		&& tar xfz postgresql-16.0.tar.gz \
		&& cd postgresql-16.0 \
		&& ./configure && make && sudo make install \
		&& cd .. && rm -rf postgresql-16.0

mypaint:
	flatpak install flathub org.mypaint.MyPaint
	# run with: flatpak run org.mypaint.MyPaint

discord:
	mkdir -p snapshots/discord \
		&& cd snapshots/discord \
		&& wget https://dl.discordapp.net/apps/linux/0.0.35/discord-0.0.35.deb \
		&& sudo dpkg -i discord-0.0.35.deb

sgb:
	# See also https://www-cs-faculty.stanford.edu/~knuth/sgb.html
	# Please remember to adjust the line:
	# 	CFLAGS = -O3 -fPIC -I$(INCLUDEDIR) $(SYS)
	# in the corresponding makefile to allow usage from shared libraries.
	mkdir -p snapshots/sgb \
		&& cd snapshots/sgb \
		&& wget ftp://ftp.cs.stanford.edu/pub/sgb/sgb.tar.gz \
		&& tar xfz sgb.tar.gz \
		&& make tests && sudo make install && sudo make installdemos

wolfram:
	mkdir -p snapshots/wolfram \
		&& cd snapshots/wolfram \
		&& wget https://files.wolframcdn.com/WolframEngine/13.3.0.0/WolframEngine_13.3.0_LINUX.sh?4ae6ee529e4e0d5967853f9964b23dfeb8566c7eb008cacb70942b0d3beb0b48c271d2e5103bbc8690861f9e039c438b5db98d1a88b401b7fa624c40216e9804dbc221df024b70096b601d3d38b35c8917a1425d6ec28726c8f4bc875fc3d0f5af3feb990d \
		&& sudo bash WolframEngine_13.3.0_LINUX.sh?4ae6ee529e4e0d5967853f9964b23dfeb8566c7eb008cacb70942b0d3beb0b48c271d2e5103bbc8690861f9e039c438b5db98d1a88b401b7fa624c40216e9804dbc221df024b70096b601d3d38b35c8917a1425d6ec28726c8f4bc875fc3d0f5af3feb990d
	sudo rm -rf /usr/local/lib/libWSTP64i4.so
	sudo ln -s /usr/local/Wolfram/WolframEngine/13.3/SystemFiles/Links/WSTP/DeveloperKit/Linux-x86-64/CompilerAdditions/libWSTP64i4.so /usr/local/lib/libWSTP64i4.so
	sudo ln -s /usr/local/Wolfram/WolframEngine/13.3/SystemFiles/Links/WSTP/DeveloperKit/Linux-x86-64/CompilerAdditions/wstp.h /usr/local/include/wstp.h
	sudo ldconfig

tor:
	mkdir -p snapshots/tor \
		&& cd snapshots/tor \
		&& wget https://www.torproject.org/dist/torbrowser/12.5.1/tor-browser-linux64-12.5.1_ALL.tar.xz \
		&& tar xfJ tor-browser-linux64-12.5.1_ALL.tar.xz

java:
	mkdir -p snapshots/java \
		&& cd snapshots/java \
		&& wget https://download.oracle.com/java/21/latest/jdk-21_linux-x64_bin.tar.gz \
		&& tar xfz jdk-21_linux-x64_bin.tar.gz

eclipse-c:
	mkdir -p snapshots/eclipse-c \
		&& cd snapshots/eclipse-c \
		&& wget https://ftp.fau.de/eclipse/technology/epp/downloads/release/2023-09/R/eclipse-cpp-2023-09-R-linux-gtk-x86_64.tar.gz \
		&& tar xfz eclipse-cpp-2023-09-R-linux-gtk-x86_64.tar.gz

eclipse-java:
	mkdir -p snapshots/eclipse-java \
		&& cd snapshots/eclipse-java \
		&& wget https://ftp.fau.de/eclipse/technology/epp/downloads/release/2023-09/R/eclipse-java-2023-09-R-linux-gtk-x86_64.tar.gz \
		&& tar xfz eclipse-java-2023-09-R-linux-gtk-x86_64.tar.gz

virtualbox:
	mkdir -p snapshots/virtualbox \
		&& cd snapshots/virtualbox \
		&& wget https://download.virtualbox.org/virtualbox/7.0.10/VirtualBox-7.0.10-158379-Linux_amd64.run \
		&& chmod +x VirtualBox-7.0.10-158379-Linux_amd64.run \
		&& sudo ./VirtualBox-7.0.10-158379-Linux_amd64.run

virtualbox-deb:
	mkdir -p snapshots/virtualbox \
		&& cd snapshots/virtualbox \
		&& wget https://download.virtualbox.org/virtualbox/7.0.10/virtualbox-7.0_7.0.10-158379~Ubuntu~jammy_amd64.deb \
		&& wget https://download.virtualbox.org/virtualbox/7.0.10/Oracle_VM_VirtualBox_Extension_Pack-7.0.10.vbox-extpack \
		&& sudo apt install ./virtualbox-7.0_7.0.10-158379~Ubuntu~jammy_amd64.deb

rustdesk:
	mkdir -p snapshots/rustdesk \
		&& cd snapshots/rustdesk \
		&& wget https://github.com/rustdesk/rustdesk/releases/download/1.2.2/rustdesk-1.2.2-x86_64.deb \
		&& sudo apt install ./rustdesk-1.2.2-x86_64.deb

emacs:
	sudo apt build-dep emacs
	mkdir -p snapshots/emacs \
		&& cd snapshots/emacs \
		&& wget http://mirror.kumi.systems/gnu/emacs/emacs-29.1.tar.xz \
		&& ./configure && make && sudo make install

######################################################################################################
# Working copies
######################################################################################################

wc-word2vec:
	mkdir -p working-copies/ces \
		&& cd working-copies/ces \
		&& rm -rf word2vec \
		&& git clone git@github.com:massimo-nocentini/word2vec.git \
		&& cd word2vec \
		&& make

wc-non-layered-tidy-trees.c:
	mkdir -p working-copies/ces \
		&& cd working-copies/ces \
		&& rm -rf non-layered-tidy-trees.c \
		&& git clone git@github.com:massimo-nocentini/non-layered-tidy-trees.c.git \
		&& cd non-layered-tidy-trees.c/src \
		&& make linux && sudo make install

#&& cd pharo-vm && git checkout --track origin/pharo-12 && cd .. 
wc-pharo-vm:
	mkdir -p working-copies/ces 
	cd working-copies/ces \
		&& rm -rf pharo-vm pharo-vm-build build \
		&& git clone git@github.com:massimo-nocentini/pharo-vm.git \
		&& cmake -S pharo-vm/ -B pharo-vm-build -DPHARO_DEPENDENCIES_PREFER_DOWNLOAD_BINARIES=TRUE \
		&& cmake --build pharo-vm-build/ --target install
	rm -rf snapshots/pharo-vm
	cp -r working-copies/ces/pharo-vm-build/build/dist/ snapshots/pharo-vm
	cd snapshots/pharo-vm/lib && rm -rf libcairo.so* libfontconfig.so* libharfbuzz.so* libssh2.so*
	rm -rf working-copies/ces/build working-copies/ces/pharo-vm-build

wc-tree-sitter:
	mkdir -p working-copies/ces \
		&& cd working-copies/ces \
		&& rm -rf tree-sitter \
		&& git clone git@github.com:tree-sitter/tree-sitter.git \
		&& cd tree-sitter \
		&& make && sudo make install

wc-timsort.c:
	mkdir -p working-copies/ces \
		&& cd working-copies/ces \
		&& rm -rf timsort.c \
		&& git clone git@github.com:massimo-nocentini/timsort.c.git \
		&& cd timsort.c/src \
		&& make linux && sudo make install

wc-fastText:
	mkdir -p working-copies/ces \
		&& cd working-copies/ces \
		&& rm -rf fastText \
		&& git clone https://github.com/facebookresearch/fastText.git \
		&& cd fastText \
		&& mkdir build && cd build && cmake .. \
		&& make && sudo make install

wc-luaunit:
	mkdir -p working-copies/luas \
		&& cd working-copies/luas \
		&& rm -rf luaunit \
		&& git clone git@github.com:bluebird75/luaunit.git \
		&& sudo cp luaunit/luaunit.lua /usr/local/share/lua/5.4/

wc-json:
	mkdir -p working-copies/luas \
		&& cd working-copies/luas \
		&& rm -rf json.lua \
		&& git clone git@github.com:rxi/json.lua.git \
		&& sudo cp json.lua/json.lua /usr/local/share/lua/5.4/

wc-category.lua:
	mkdir -p working-copies/luas \
		&& cd working-copies/luas \
		&& rm -rf category.lua \
		&& git clone git@github.com:massimo-nocentini/category.lua.git \
		&& cd category.lua/src \
		&& sudo make install && make test

wc-operator.lua:
	mkdir -p working-copies/luas \
		&& cd working-copies/luas \
		&& rm -rf operator.lua \
		&& git clone git@github.com:massimo-nocentini/operator.lua.git  \
		&& cd operator.lua/src \
		&& sudo make install

wc-libc.lua:
	mkdir -p working-copies/luas \
		&& cd working-copies/luas \
		&& rm -rf libc.lua \
		&& git clone git@github.com:massimo-nocentini/libc.lua.git \
		&& cd libc.lua/src \
		&& make linux && sudo make install && make test

wc-curl.lua:
	mkdir -p working-copies/luas \
		&& cd working-copies/luas \
		&& rm -rf curl.lua \
		&& git clone git@github.com:massimo-nocentini/curl.lua.git \
		&& cd curl.lua/src \
		&& make linux && sudo make install-linux

wc-cairo.lua:
	mkdir -p working-copies/luas \
		&& cd working-copies/luas \
		&& rm -rf cairo.lua \
		&& git clone git@github.com:massimo-nocentini/cairo.lua.git \
		&& cd cairo.lua/src \
		&& make && sudo make install

wc-lua.lua:
	mkdir -p working-copies/luas \
		&& cd working-copies/luas \
		&& rm -rf lua.lua \
		&& git clone git@github.com:massimo-nocentini/lua.lua.git \
		&& cd lua.lua/src \
		&& make && sudo make install && make test

wc-timsort.lua:
	mkdir -p working-copies/luas \
		&& cd working-copies/luas \
		&& rm -rf timsort.lua \
		&& git clone git@github.com:massimo-nocentini/timsort.lua.git \
		&& cd timsort.lua/src \
		&& make && sudo make install && make test

wc-non-layered-tidy-trees.lua:
	mkdir -p working-copies/luas \
		&& cd working-copies/luas \
		&& rm -rf non-layered-tidy-trees.lua \
		&& git clone git@github.com:massimo-nocentini/non-layered-tidy-trees.lua.git \
		&& cd non-layered-tidy-trees.lua/src \
		&& make && sudo make install 

wc-tree-sitter.lua:
	mkdir -p working-copies/luas \
		&& cd working-copies/luas \
		&& rm -rf tree-sitter.lua \
		&& git clone --recurse-submodules git@github.com:massimo-nocentini/tree-sitter.lua.git \
		&& cd tree-sitter.lua/src \
		&& make linux && sudo make install-linux

wc-stream.lua:
	mkdir -p working-copies/luas \
		&& cd working-copies/luas \
		&& rm -rf stream.lua \
		&& git clone git@github.com:massimo-nocentini/stream.lua.git \
		&& cd stream.lua/src \
		&& sudo make install && make test 

wc-pgsql.lua:
	mkdir -p working-copies/luas \
		&& cd working-copies/luas \
		&& rm -rf pgsql.lua \
		&& git clone git@github.com:massimo-nocentini/pgsql.lua.git \
		&& cd pgsql.lua/src \
		&& make && sudo make install 

wc-wolfram.lua:
	mkdir -p working-copies/luas \
		&& cd working-copies/luas \
		&& rm -rf wolfram.lua \
		&& git clone git@github.com:massimo-nocentini/wolfram.lua.git \
		&& cd wolfram.lua/src \
		&& make && sudo make install 

wc-datetimeformatter.c:
	mkdir -p working-copies/ces \
		&& cd working-copies/ces \
		&& rm -rf datetimeformatter.c \
		&& git clone git@github.com:massimo-nocentini/datetimeformatter.c.git \
		&& cd datetimeformatter.c/src \
		&& make && sudo make install 

wc-datetimeformatter.lua:
	mkdir -p working-copies/luas \
		&& cd working-copies/luas \
		&& rm -rf datetimeformatter.lua \
		&& git clone git@github.com:massimo-nocentini/datetimeformatter.lua.git \
		&& cd datetimeformatter.lua/src \
		&& make && sudo make install 

wc-exactcover.lua:
	mkdir -p working-copies/luas \
		&& cd working-copies/luas \
		&& rm -rf exactcover.lua \
		&& git clone git@github.com:massimo-nocentini/exactcover.lua.git
		#&& cd exactcover.lua/src && make && sudo make install 

######################################################################################################

working-copies-lua: wc-luaunit wc-json wc-category.lua wc-operator.lua wc-libc.lua wc-curl.lua wc-cairo.lua wc-lua.lua wc-timsort.lua wc-non-layered-tidy-trees.lua wc-tree-sitter.lua wc-stream.lua wc-pgsql.lua wc-wolfram.lua wc-datetimeformatter.lua wc-exactcover.lua

working-copies: wc-word2vec wc-non-layered-tidy-trees.c wc-pharo-vm wc-tree-sitter wc-timsort.c wc-fastText wc-datetimeformatter.c working-copies-lua

snapshots: google-chrome python vim code lua texlive mypaint pgsql discord sgb wolfram tor java eclipse-c eclipse-java virtualbox-deb rustdesk

all: system flatpak snapshots working-copies
