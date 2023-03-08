
// SPDX-License-Identifier: MIT

%lang starknet

from starkware.cairo.common.cairo_builtins import HashBuiltin

from starkware.starknet.common.syscalls import get_caller_address

from openzeppelin.upgrades.library import Proxy


@storage_var
func transaction_number() -> (number: felt) {
}

@event
func anchor(
    anchor_file_hash_low: felt,
    anchor_file_hash_high: felt,
    transaction_number: felt,
    number_of_operation: felt,
    writer: felt,
) {
}
//
// Initializer
//

@external
func initializer{syscall_ptr: felt*, pedersen_ptr: HashBuiltin*, range_check_ptr}(
    proxy_admin: felt
) {
    Proxy.initializer(proxy_admin);
    return ();
}

//
// Upgrades
//


@external
func upgrade{syscall_ptr: felt*, pedersen_ptr: HashBuiltin*, range_check_ptr}(
    new_implementation: felt
) {
    Proxy.assert_only_admin();
    Proxy._set_implementation_hash(new_implementation);
    return ();
}


@external
func anchor_hash{syscall_ptr: felt*, pedersen_ptr: HashBuiltin*, range_check_ptr}(
    anchor_hash_low: felt, anchor_hash_high: felt, number_of_operation: felt
) {
    let (caller_address) = get_caller_address();
    let (current_number) = transaction_number.read();
    anchor.emit(
        anchor_file_hash_low=anchor_hash_low,
        anchor_file_hash_high=anchor_hash_high,
        transaction_number=current_number,
        number_of_operation=number_of_operation,
        writer=caller_address,
    );
    transaction_number.write(current_number + 1);
    return ();
}
