AC_DEFUN([CHECK_ERLANG], [
#
# Erlang checks
#

AM_CONDITIONAL([HAVE_ERLANG],[false])
save_CFLAGS="$CFLAGS"
save_LIBS="$LIBS"

AC_PATH_PROG([ERLANG], ["erl"], ["no"], ["$PATH:/usr/bin:/usr/local/bin"])

if test "$ERLANG" != "no" ; then
    AC_MSG_CHECKING([erlang version])
    ERLANG_VER="`$ERLANG -version 2>&1 | cut -d' ' -f6`"

    if test -z "$ERLANG_VER" ; then
        AC_MSG_ERROR([Unable to detect erlang version])
    fi
    AC_MSG_RESULT([$ERLANG_VER])

    ERLANG_LIBDIR=`$ERLANG -noshell -eval 'io:format("~n~s/lib~n", [[code:lib_dir("erl_interface")]]).' -s erlang halt | tail -n 1`
    AC_MSG_CHECKING([erlang libdir])
    if test -z "`echo $ERLANG_LIBDIR`" ; then
        AC_MSG_ERROR([failed])
    else
        ERLANG_LDFLAGS="-L$ERLANG_LIBDIR $ERLANG_LDFLAGS"
        LIBS="-L$ERLANG_LIBDIR $LIBS"
    fi
    AC_MSG_RESULT([$ERLANG_LIBDIR])

    ERLANG_INCDIR=`$ERLANG -noshell -eval 'io:format("~n~s/include~n", [[code:lib_dir("erl_interface")]]).' -s erlang halt | tail -n 1`
    AC_MSG_CHECKING([erlang incdir])
    if test -z "`echo $ERLANG_INCDIR`" ; then
        AC_MSG_ERROR([failed])
    else
        ERLANG_CFLAGS="-I$ERLANG_INCDIR $ERLANG_CFLAGS"
        CFLAGS="-I$ERLANG_INCDIR $CFLAGS"
    fi
    AC_MSG_RESULT([$ERLANG_INCDIR])

    AC_CHECK_HEADERS([ei.h], [has_ei_h="yes"], [has_ei_h="no"])

    ERLANG_LIB="ei"

    # check lib ei
    AC_CHECK_LIB([$ERLANG_LIB], [ei_encode_version], [has_libei="yes"], [has_libei="no"])
    # maybe someday ei will actually expose this?
    AC_CHECK_LIB([$ERLANG_LIB], [ei_link_unlink], [ERLANG_CFLAGS="$ERLANG_CFLAGS -DEI_LINK_UNLINK"])

    if test "$has_libei" = "no" ; then
        AS_IF([test "$with_erlang" = "try"],
            [AC_MSG_WARN([$ERLANG_LIB is unusable])],
            [AC_MSG_ERROR([$ERLANG_LIB is unusable])]
        )
    elif test "$has_ei_h" = "no"; then
        AS_IF([test "$with_erlang" = "try"],
            [AC_MSG_WARN([ei.h is unusable - are the erlang development headers installed?])],
            [AC_MSG_ERROR([ei.h is unusable - are the erlang development headers installed?])]
        )
    else
        ERLANG_MAJOR="`echo "$ERLANG_VER" | sed 's/\([[^.]][[^.]]*\).*/\1/'`"
        ERLANG_MINOR="`echo "$ERLANG_VER" | sed 's/[[^.]][[^.]]*.\([[^.]][[^.]]*\).*/\1/'`"
        ERLANG_LDFLAGS="$ERLANG_LDFLAGS -lei"
        AC_MSG_NOTICE([Your erlang is ok])
        AC_SUBST([ERLANG_CFLAGS],  [$ERLANG_CFLAGS])
        AC_SUBST([ERLANG_LDFLAGS], [$ERLANG_LDFLAGS])
        AC_SUBST([ERLANG_VERSION], [$ERLANG_VER])
        AC_SUBST([ERLANG_MAJOR], [$ERLANG_MAJOR])
        AC_SUBST([ERLANG_MINOR], [$ERLANG_MINOR])
        AC_SUBST([ERLANG_INCLUDE], [$ERLANG_INCDIR])
        AC_SUBST([ERLANG_LIBDIR], [$ERLANG_LIBDIR])
        AM_CONDITIONAL([HAVE_ERLANG],[true])
    fi

    LIBS="$save_LIBS"
    CFLAGS="$save_CFLAGS"

else
    AC_MSG_ERROR([Could not find erlang])
fi

])