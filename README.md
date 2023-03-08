# Starknet Contract

In this repository you will find all the necesarry information to deploy a SidetreeAnchoring contract implementing a proxy pattern to allow for upgradeability on the contract logic as well as future proofing for the upcoming Cairo Versions

# Contracts

All contracts that rely on a proxy to be exposed must have an upgrade function to change the implementation

```cairo
from openzeppelin.upgrades.library import Proxy

@external
func upgrade{syscall_ptr: felt*, pedersen_ptr: HashBuiltin*, range_check_ptr}(
    new_implementation: felt
) {
    Proxy.assert_only_admin();
    Proxy._set_implementation_hash(new_implementation);
    return ();
}
```
`Proxy` is an OpenZeppelin library that contains the bulk of the logic to implement the proxy pattern

## sidetree_v0.cairo

A simple sidetree anchoring contract without keeping any state on the blockchain ensuring lower transactions costs

## sidetree_v1.cairo


A simple sidetree anchoring contract using a variable to keep state on the blockchain

## Proxy.cairo

This is the proxy contract that will be the entry point for all the future contracts, the ABI is not really used as you will be using the current contract version ABI againts its address 

# Setting up the CLI

- Python 3.9 is required 


## Environment

https://www.cairo-lang.org/docs/quickstart.html#quickstart

## Account

https://www.cairo-lang.org/docs/hello_starknet/account_setup.html

If you are going to use mainnet change 

```sh
export STARKNET_NETWORK=alpha-goerli
```

to

```sh
export STARKNET_NETWORK=alpha-mainnet
```


### Considerations

After the enviroment is set the account info will be saved under $HOME/.starknet_accounts/starknet_open_zeppelin_accounts.json

to create a new one, generate a backup of the file and create a new account

## Extras

Inside your virtual enviroment run:

```sh
pip install cairo-nile
pip install openzeppelin-cairo-contracts
pip install starknet.py
```


# Get the contracts up

After having your enviroment ready

## Compilation

Run the compile.sh script, which will compile all contracts under `cairo-proxy/contracts` and move the results into the `abi` and `compiled` folders

## Declaring

Running the `declare.sh` script will declare the proxy contract and the v0 one

or you can manually do it running: 
```
starknet declare --contract compiled/YOUR_DESIRED_CONTRACT.json
```

## Deploying

The deployment of an starknet contract is made via de UDC https://medium.com/starknet-edu/deploying-to-starknet-with-the-universal-deployer-contract-c6de07092bfb

to do so you must invoke the `deployContract` 


an example of deployment given the sidetree_v0.cairo would be:
```sh
starknet invoke     --address 0x041a78e741e5af2fec34b695679bc6891742439f7afb8484ecd7766661ad02bf     --abi ../../UDC.json     --function deployContract     --inputs 0x780420e10f0de9ab10600d6a3a0023f996522bba30d98808c07f7e432f6a05d 8888 0 4 0x76a33aacc197c42ff86616f63ab77ed90213f989001fe98e0a5662430158051 1295919550572838631247819983596733806859788957403169325509326258146877103642 1 0x33a8ea1e0c0e638627b6627353f5edcebaadd922accf9f1031fd3e2fe2a412d

```

The variables are as follows:

```sh
starknet invoke     --address 0x041a78e741e5af2fec34b695679bc6891742439f7afb8484ecd7766661ad02bf     --abi ../../UDC.json     --function deployContract     --inputs PROXY_CONTRACT_HASH SALTING UNIQUE PROXY_CONTRACY_HASH_CALLDATA_LEN PROXY_CONTRACT_CALLDATA 
```

Where the proxy calldata is:

```sh
PROX_CONTRACT_CALLDATA = SIDETREE_CONTRACT_HASH SIDETREE_CONTRACT_SELECTOR SIDETREE_V0_CALLDATA CONTRACT_OWNER_ADDRES
```

To get the `SIDETREE_CONTRACT_SELECTOR` which is the selector number for the initializing function of the actual contract. Example:
