#!/bin/bash

if [ -z "$1" ]
then
echo "Error: a salting number as an input is required"
echo "Usage: ${0} SALT_NUMBER"
exit 1
fi

./compile.sh

cd ..

echo "Declaring proxy"
PROXY_CLASS_HASH="$(starknet declare --contract compiled/Proxy.json  | grep 'Contract class' | grep -o '[[:digit:]].*$')"
echo "Proxy contract class hash: ${PROXY_CLASS_HASH}"
echo "Declaring v1"
SIDETREE_CONTRACT_HASH="$(starknet declare --contract compiled/sidetree_v1.json  | grep 'Contract class' | grep -o '[[:digit:]].*$')"
echo "Sidetree contract class hash: ${SIDETREE_CONTRACT_HASH}"

echo "Deploying contract"
#PROXY_CONTRACT_CALLDATA= SIDETREE_CONTRACT_HASH SIDETREE_CONTRACT_SELECTOR SIDETREE_V1_CALLDATA_LEN CONTRACT_OWNER_ADDRES

SALT_NUMBER=$1
ACCOUNT_ADDRESS=$(jq .[\"${STARKNET_NETWORK}\"]."__default__".address $HOME/.starknet_accounts/starknet_open_zeppelin_accounts.json)
ACCOUNT_ADDRESS=$(echo ${ACCOUNT_ADDRESS} | tr -d '"')
echo "Contract owner: ${ACCOUNT_ADDRESS}"
UNIQUE=0
UDC_ADDRESS=0x041a78e741e5af2fec34b695679bc6891742439f7afb8484ecd7766661ad02bf
SIDETREE_INITIALIZER_CALLDATA_LEN=1
SIDETREE_CONTRACT_CALLDATA_LEN=4
SELECTOR=$(python scripts/get_selector.py initializer)

starknet invoke --address ${UDC_ADDRESS} \
  --abi abi/UDC.json --function deployContract \
  --inputs ${PROXY_CLASS_HASH} ${SALT_NUMBER} ${UNIQUE} \
  ${SIDETREE_CONTRACT_CALLDATA_LEN} ${SIDETREE_CONTRACT_HASH} ${SELECTOR} ${SIDETREE_INITIALIZER_CALLDATA_LEN} ${ACCOUNT_ADDRESS} 
