
safe:
	echo "Safe rule to avoid unwanted compilations"

system:
	sudo apt install build-essential gitg libgit2-dev rlwrap cmake \
		libpango-1.0-0 libpangocairo-1.0-0 libpango1.0-dev fontconfig libfontconfig-dev libglib2.0-0 \
		synaptic libfuse2 libstdc++-13-dev gcc-13-x86-64-linux-gnux32 flatpak piper \
		curl libcurl4 libcurl4-gnutls-dev filezilla gedit
	# now add a source for flatpak
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

pgsql:
	sudo apt build-dep postgresql-15
	mkdir -p snapshots/pgsql \
		&& cd snapshots/pgsql \
		&& wget https://ftp.postgresql.org/pub/source/v15.3/postgresql-15.3.tar.gz \
		&& tar xfz postgresql-15.3.tar.gz \
		&& cd postgresql-15.3 \
		&& ./configure && make && sudo make install \
		&& cd .. && rm -rf postgresql-15.3

mypaint:
	flatpak install flathub org.mypaint.MyPaint
	# run with: flatpak run org.mypaint.MyPaint

discord:
	mkdir -p snapshots/discord \
		&& cd snapshots/discord \
		&& wget https://dl.discordapp.net/apps/linux/0.0.27/discord-0.0.27.tar.gz \
		&& tar xfz discord-0.0.27.tar.gz

sgb:
	# See also https://www-cs-faculty.stanford.edu/~knuth/sgb.html
	mkdir -p snapshots/sgb \
		&& cd snapshots/sgb \
		&& wget ftp://ftp.cs.stanford.edu/pub/sgb/sgb.tar.gz \
		&& tar xfz sgb.tar.gz \
		&& make tests && sudo make install && sudo make installdemos

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

wc-pharo-vm:
	mkdir -p working-copies/ces \
		&& cd working-copies/ces \
		&& rm -rf pharo-vm \
		&& git clone git@github.com:pharo-project/pharo-vm.git \
		&& rm -rf pharo-vm-build build \
		&& cmake -S pharo-vm/ -B pharo-vm-build -DPHARO_DEPENDENCIES_PREFER_DOWNLOAD_BINARIES=TRUE \
		&& cmake --build pharo-vm-build/ --target install \
		&& rm -rf build

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

######################################################################################################

working-copies-lua: wc-luaunit wc-json wc-category.lua wc-operator.lua wc-libc.lua wc-curl.lua wc-cairo.lua wc-lua.lua wc-timsort.lua wc-non-layered-tidy-trees.lua wc-tree-sitter.lua wc-stream.lua

working-copies: wc-word2vec wc-non-layered-tidy-trees.c wc-pharo-vm wc-tree-sitter wc-timsort.c wc-fastText \
	working-copies-lua

snapshots: google-chrome python vim code lua texlive mypaint pgsql discord

all: system snapshots working-copies
