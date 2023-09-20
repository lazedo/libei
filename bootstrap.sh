#!/bin/bash

# warnings
touch NEWS
touch README
touch AUTHORS
touch ChangeLog

rm -rf autom4te*.cache

# libtoolize=`which libtoolize`
aclocal
# $libtoolize -i --copy
autoreconf -i
# autoheader --warnings=none
automake --add-missing
