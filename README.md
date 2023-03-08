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