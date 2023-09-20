ACLOCAL_AMFLAGS = -I m4
AM_CFLAGS = -Isrc -I$(abs_srcdir)/src -Iinterface -I$(abs_srcdir)/interface -fPIC -O3
AUTOMAKE_OPTIONS = gnu
NAME = libei

# if HAVE_ERLANG

pkgconfigdir = $(libdir)/pkgconfig
pkgconfig_DATA = ei.pc

library_includedir = $(prefix)/include/ei

library_include_HEADERS	= 
#library_include_HEADERS	= include/ei.h \
#include/ei_connect.h \
#include/eicode.h

install-exec-am:
	@mkdir -p $(DESTDIR)/$(bindir)
	@mkdir -p $(DESTDIR)/$(libdir)
	@mkdir -p $(DESTDIR)/$(includedir)/ei
	@install `which epmd` $(DESTDIR)$(bindir)/epmd
	@install $(ERLANG_LIBDIR)/libei.a $(DESTDIR)$(libdir)
	@install $(ERLANG_LIBDIR)/libei_st.a $(DESTDIR)$(libdir)
	@install $(ERLANG_INCLUDE)/ei.h $(DESTDIR)$(includedir)/ei
	@install $(ERLANG_INCLUDE)/ei_connect.h $(DESTDIR)$(includedir)/ei
	@install $(ERLANG_INCLUDE)/eicode.h $(DESTDIR)$(includedir)/ei



# else
#
#install: error
#all: error
#error:
#	$(error You must install erlang to build this module)
#
#endif
