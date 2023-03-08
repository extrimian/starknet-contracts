#!/bin/bash
cd cairo-proxy
nile compile
cd ..
find ./cairo-proxy/artifacts/ -maxdepth 1 -type f -print0 | xargs -0 mv -t compiled
find ./cairo-proxy/artifacts/abis -maxdepth 1 -type f -print0 | xargs -0 mv -t abi
echo "✅ Moved files to according folder"