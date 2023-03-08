
# declare implementation contract
IMPLEMENTATION = await starknet.declare(
    "path/to/implementation.cairo",
)

# deploy proxy
selector = get_selector_from_name('initializer')
params = [
    proxy_admin   # admin account
]
PROXY = await starknet.deploy(
    "path/to/proxy.cairo",
    constructor_calldata=[
        IMPLEMENTATION.class_hash,  # set implementation contract class hash
        selector,                   # initializer function selector
        len(params),                # calldata length in felt
        *params                     # actual calldata
    ]
)

