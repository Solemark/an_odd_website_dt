#!/bin/sh

# create the build folder
if [ ! -d build ]; then
  mkdir build
fi

# build the server
dart compile exe main.dart
# move the executable into the build folder
if [ -f main.exe ]; then
  mv ./main.exe build/server
fi

# clone static files into the same directory as executable
cp -r ./static build/static
