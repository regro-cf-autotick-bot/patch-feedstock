#!/bin/bash
# Get an updated config.sub and config.guess for regular builds. Bootstrap
# builds intentionally avoid the libtool dependency.
if [[ "${CONDA_BUILD_BOOTSTRAPPING:-}" != "yes" ]]; then
  cp $BUILD_PREFIX/share/libtool/build-aux/config.* ./build-aux
fi
./configure --prefix="${PREFIX}" --host=${HOST}
make -j${CPU_COUNT} ${VERBOSE_AT}
if [[ "${CONDA_BUILD_CROSS_COMPILATION}" != "1" ]]; then
make check
fi
make install
