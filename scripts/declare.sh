#!/bin/bash


./compile.sh

cd ..


echo "Declaring proxy"
starknet declare --contract compiled/Proxy.json
echo "--------------------------------------"
echo "Declaring sidetree contract V1"
starknet declare --contract compiled/sidetree_v1.json 



