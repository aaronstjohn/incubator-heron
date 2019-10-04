#!/bin/bash -ex

build_heron() {
    pushd /tmp
        wget http://ftpmirror.gnu.org/libtool/libtool-2.4.6.tar.gz
        tar xf libtool*
        cd libtool-2.4.6
        sh configure --prefix /usr/local
        make install 
    popd
    pushd /vagrant
        export CC=gcc-4.8
        export CXX=g++-4.8
        export PATH=/sbin:$PATH
        bazel clean
        # ~/bin/bazel clean
        ./bazel_configure.py
        bazel --bazelrc=tools/travis/bazel.rc build --config=darwin heron/... --verbose_failures=true
        # ~/bin/bazel --bazelrc=tools/travis/bazel.rc build --config=ubuntu heron/...
    popd
}
build_heron