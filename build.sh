#!/usr/bin/env bash
set -euxo pipefail

git submodule init
git submodule update --recursive --remote

cp ./src/Makefile ./src/tree-sitter-slim/
cd ./src/tree-sitter-slim

npm i -D 2>/dev/null
npm i -D tree-sitter-cli

npx tree-sitter generate
../compile_parser.sh "$PWD" "/Applications/Nova.app"

codesign -s - libtree-sitter-slim.dylib
mv libtree-sitter-slim.dylib ../../slim-tree-sitter.novaextension/Syntaxes/

