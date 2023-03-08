from starkware.starknet.compiler.compile import get_selector_from_name
import sys

def main():
    
    name = 'initializer'
    if len(sys.argv) > 1: 
        name = sys.argv[1]
    # deploy proxy
    selector = get_selector_from_name(name)
    print(selector)
    
    
if __name__ == "__main__":
    main();