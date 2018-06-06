#!/bin/bash
cd nspr &&
sed -ri 's#^(RELEASE_BINS =).*#\1#' pr/src/misc/Makefile.in &&
sed -i 's#$(LIBRARY) ##' config/rules.mk &&
./configure --prefix=/usr \
            --with-mozilla \
            --with-pthreads \
            $([[ $SHED_NATIVE_TARGET =~ ^aarch64-.* ]] && echo --enable-64bit) &&
make -j $SHED_NUM_JOBS &&
make DESTDIR="$SHED_FAKE_ROOT" install
