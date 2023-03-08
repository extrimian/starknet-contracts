#!/bin/bash

SELECTOR="$(python proxy_script.py initializer)"

if [ -z "$1" ]
then
echo "Error: a salting number as an input is required"
echo "Usage: ${0} SALT_NUMBER"
exit 1
fi
./compile.sh

cd ..


echo "Declaring proxy"
starknet declare --contract compiled/Proxy.json
starknet declare --contract compiled/sidetree_v0.json 
echo "Sidetree contract class hash: ${SIDETREE_CONTRACT_HASH}"



