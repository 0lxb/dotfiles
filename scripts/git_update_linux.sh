#!/bin/bash

cd /svn/qemu_aarch64/linux

git remote update && git pull

git pull

git branch -v

for branch in $(git branch --list --no-color | cut -f 3 -d ' '); do
	echo "git pull $branch"
	git checkout "${branch}"
	git pull
done

git checkout master

git branch -v

make ARCH=arm64 LLVM=1 -C /svn/qemu_aarch64/linux O=/svn/qemu_aarch64/arm64_build/linux olddefconfig

make ARCH=arm64 LLVM=1 -C /svn/qemu_aarch64/linux O=/svn/qemu_aarch64/arm64_build/linux Image modules cscope tags -j4

#/svn/qemu_aarch64/linux/scripts/clang-tools/gen_compile_commands.py

exit 0
