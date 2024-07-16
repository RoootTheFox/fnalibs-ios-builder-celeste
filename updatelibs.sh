#!/bin/sh

# Clones or pulls the latest fnalibs.
# Intended for use with FNA on iOS / tvOS.
# Requires git, cmake, and python3 to be installed.
# Written by Caleb Cornett.
# Usage: ./updatelibs.sh

builder_dir=$(pwd)

# Clone repos if needed
if [ ! -d "./SDL2/" ]; then
	echo "SDL2 folder not found. Cloning now..."
	git clone https://github.com/libsdl-org/SDL.git SDL2
	cd "./SDL2/"
	git checkout 257cacab183b312bbe60bd7967eee44a3ad7be85
	cd "$builder_dir"

	echo ""
fi

if [ ! -d "./FNA3D/" ]; then
	echo "FNA3D folder not found. Cloning now..."
	git clone https://github.com/FNA-XNA/FNA3D.git --branch 21.03 --single-branch
	# from my experience the submodules fail to clone, so we have to do it manually
	cd "./FNA3D/"
	git clone https://github.com/FNA-XNA/MojoShader --recursive
	git clone https://github.com/KhronosGroup/Vulkan-Headers --recursive
	cd "$builder_dir/FNA3D/MojoShader"
	git checkout c9037d90fa2f59b6be65d1391ca11d345356bad1
	cd "$builder_dir/FNA3D/Vulkan-Headers"
	git checkout 85470b32ad5d0d7d67fdf411b6e7b502c09c9c52
	cd "$builder_dir"
	# make sure everything is on the correct ref
	git submodule update --init --recursive

	echo ""
fi

echo "Patching FNA3D..."
cd "./FNA3D/"
git apply < "$builder_dir/FNA3D-fix-FNA3D_SysRenderer.h-not-found.patch"
cd "$builder_dir"

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
	cd "$builder_dir"

	echo ""
fi

if [ ! -d "./MoltenVK" ]; then
	echo "MoltenVK folder not found. Cloning now..."
	git clone --recursive https://github.com/KhronosGroup/MoltenVK --branch v1.2.9 --single-branch
fi
