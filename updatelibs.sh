#!/bin/sh

# Clones or pulls the latest fnalibs.
# Intended for use with FNA on iOS / tvOS.
# Requires git, cmake, and python3 to be installed.
# Written by Caleb Cornett.
# Usage: ./updatelibs.sh

# Clone repos if needed
if [ ! -d "./SDL2/" ]; then
	echo "SDL2 folder not found. Cloning now..."
	git clone https://github.com/libsdl-org/SDL.git SDL2
	cd "./SDL2/"
	git checkout 257cacab183b312bbe60bd7967eee44a3ad7be85
	cd ..

	echo ""
fi

if [ ! -d "./FNA3D/" ]; then
	echo "FNA3D folder not found. Cloning now..."
	git clone https://github.com/FNA-XNA/FNA3D.git --recursive --branch 21.03 --single-branch

	echo ""
fi

if [ ! -d "./FAudio/" ]; then
	echo "FAudio folder not found. Cloning now..."
	git clone https://github.com/FNA-XNA/FAudio.git --branch 21.03.05

	echo ""
fi

if [ ! -d "./Theorafile/" ]; then
	echo "Theorafile folder not found. Cloning now..."
	git clone https://github.com/FNA-XNA/Theorafile
	cd "./Theorafile/"
	git checkout 0c5504658a3108919e53b625287786a87529de42
	cd ..

	echo ""
fi

if [ ! -d "./MoltenVK" ]; then
	echo "MoltenVK folder not found. Cloning now..."
	git clone --recursive https://github.com/KhronosGroup/MoltenVK --branch v1.1.4 --single-branch
fi

# Check for updates...
echo "Updating SDL2..."
cd SDL2 && git pull && cd ..

echo ""
echo "Updating FNA3D..."
cd FNA3D && git pull && git submodule update && cd ..

echo ""
echo "Updating FAudio..."
cd FAudio && git pull && cd ..

echo ""
echo "Updating Theorafile..."
cd Theorafile && git pull && cd ..

echo ""
echo "Updating MoltenVK..."
cd MoltenVK && git pull && cd ..
