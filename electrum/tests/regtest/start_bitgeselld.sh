#!/usr/bin/env bash
export HOME=~
set -eux pipefail
mkdir -p ~/.electrum
cat > ~/.electrum/electrum.conf <<EOF
regtest=1
txindex=1
printtoconsole=1
rpcuser=doggman
rpcpassword=donkey
rpcallowip=127.0.0.1
zmqpubrawblock=tcp://127.0.0.1:28332
zmqpubrawtx=tcp://127.0.0.1:28333
[regtest]
rpcbind=0.0.0.0
rpcport=18554
EOF
rm -rf ~/.electrum/regtest
screen -S bitgeselld -X quit || true
screen -S bitgeselld -m -d bitgeselld -regtest
sleep 6
addr=$(electrum-cli getnewaddress)
electrum-cli generatetoaddress 150 $addr > /dev/null
