
safe:
	echo "Safe rule to avoid unwanted compilations"

system:
	sudo apt install build-essential gitg libgit2-dev rlwrap

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
	mkdir -p snapshots/lua \
		&& cd snapshots/lua \
		&& wget https://www.lua.org/ftp/lua-5.4.6.tar.gz \
		&& tar xfz lua-5.4.6.tar.gz \
		&& cd lua-5.4.6 \
		&& patch src/Makefile < ../../../lua-src-Makefile.patch \
		&& patch Makefile < ../../../lua-Makefile.patch \
		&& make "MYCFLAGS=-fPIC" "R=5.4.6" linux-readline && sudo make install

all: system google-chrome python vim code lua
