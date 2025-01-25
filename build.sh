#!/bin/sh

# build the server
dart compile exe main.dart

# create the build folder
if [ ! -d build ]; then
  mkdir build
fi

# move the executable into the build folder
if [ ! -f main.exe ]; then
  mv main.exe build/main.exe
fi

# clone static files into the same directory as exectuable
cp -r ./static build/static
