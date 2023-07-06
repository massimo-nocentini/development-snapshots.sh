
safe:
	echo "Safe rule to avoid unwanted compilations"

system:
	sudo apt install build-essential gitg libgit2-dev rlwrap cmake \
		libpango-1.0-0 libpangocairo-1.0-0 libpango1.0-dev fontconfig libfontconfig-dev libglib2.0-0 \
		synaptic libfuse2 libstdc++-13-dev gcc-13-x86-64-linux-gnux32 flatpak
	flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo

google-chrome:
	mkdir -p snapshots/google-chrome
	cd snapshots/google-chrome \
		&& wget https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb \
		&& sudo dpkg -i google-chrome-stable_current_amd64.deb 

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

mypaint:
	flatpak install flathub org.mypaint.MyPaint
	# run with: flatpak run org.mypaint.MyPaint

all: system google-chrome python vim code lua texlive mypaint
