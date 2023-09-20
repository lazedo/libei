#!/bin/bash

set -e

ERLANG_VER="`erl -version 2>&1 | cut -d' ' -f6`"
ERLANG_LIBDIR=`erl -noshell -eval 'io:format("~n~s/lib~n", [[code:lib_dir("erl_interface")]]).' -s erlang halt | tail -n 1`
ERLANG_INCDIR=`erl -noshell -eval 'io:format("~n~s/include~n", [[code:lib_dir("erl_interface")]]).' -s erlang halt | tail -n 1`

echo "erlang version is $ERLANG_VER"
echo "erlang include directory is $ERLANG_INCDIR"
echo "erlang library directory is $ERLANG_LIBDIR"

cat > teste.txt <<EOF
install-exec-am:
	@install $(which epmd) $(DESTDIR)$(bindir)/epmd
	@install $ERLANG_LIBDIR/libei.a $(DESTDIR)$(libdir)
	@install $ERLANG_LIBDIR/libei_st.a $(DESTDIR)$(libdir)
	@install $ERLANG_INCDIR/ei.h $(DESTDIR)$(includedir)
	@install $ERLANG_INCDIR/ei_connect.h $(DESTDIR)$(includedir)
	@install $ERLANG_INCDIR/eicode.h $(DESTDIR)$(includedir)

EOF
