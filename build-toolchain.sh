# env
export PREFIX="$PWD/build"
export PATH="$PREFIX/bin:$PATH"
export TARGET=x86_64-elf

# build binutils
mkdir "$PREFIX/binutils"
cd "$PREFIX/binutils"
../../binutils-2.34/configure --target=$TARGET --prefix="$PREFIX" --with-sysroot --disable-nls --disable-werror
make
make install

# build gcc
mkdir "$PREFIX/gcc"
cd "$PREFIX/gcc"
../../gcc-9.3.0/configure --target=$TARGET --prefix="$PREFIX" --disable-nls --enable-languages=c,c++ --without-headers
make all-gcc
make all-target-libgcc
make install-gcc
make install-target-libgcc