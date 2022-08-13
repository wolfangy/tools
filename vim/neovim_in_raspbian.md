**Installing Neovim from source on RaspberryPi**

- sudo apt-get install git
- sudo apt-get install libtool libtool-bin autoconf automake cmake g++ pkg-config unzip
- git clone https://github.com/neovim/neovim.git
- cd neovim
- make CMAKE_BUILD_TYPE=RelWithDebInfo
- sudo make install
