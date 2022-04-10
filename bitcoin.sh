# acquire The Source
git clone https://github.com/bitcoin/bitcoin.git ~/bitcoin

# required dependencies
brew install automake libtool pkg-config boost libevent
# wallet
brew install berkeley-db@4 sqlite
# gui
brew install qt@5
brew uninstall qt
brew install qrencode
# port mapping
brew install miniupnpc libnatpmp

# compile from The Source
pushd ~/bitcoin
cd bitcoin
./autogen.sh
./configure --without-wallet --with-gui=no
make -j 8 # match with number of cpu cores
make check && sudo make install
popd

# index all transactions
echo 'txindex=1' >> /Users/jrs/Library/Application\ Support/bitcoin.conf

# chain the blocks
bitcoind

# run at startup
cp ~/bitcoin/org.bitcoin.bitcoind.plist ~/Library/LaunchAgents/
launchctl load ~/Library/LaunchAgents/org.bitcoin.bitcoind.plist
