import asyncio
import json
from starknet_py.net import account
from starknet_py.contract import Contract
from starknet_py.net.gateway_client import GatewayClient
from starknet_py.transactions.declare import make_declare_tx
from starkware.starknet.compiler.compile import get_selector_from_name

# Local network
from starknet_py.net.models import StarknetChainId


async def main():

    # deploy proxy
    selector = get_selector_from_name('initializer')
    print(selector)

    
    
if __name__ == "__main__":
    asyncio.run(main())