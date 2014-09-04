#-*- tab-width: 4; -*-
# ex:ts=4
#
# Date created:		12 Nov 2005
# Whom:			Michael Johnson <ahze@FreeBSD.org>
#
# $FreeBSD: head/Mk/bsd.gecko.mk 363978 2014-08-04 09:11:25Z bapt $
#
# 4 column tabs prevent hair loss and tooth decay!

# bsd.gecko.mk abstracts the selection of gecko-based backends. It allows users
# and porters to support any available gecko backend without needing to build
# many conditional tests. ${USE_GECKO} is the list of backends that your port
# can handle, and ${GECKO} is set by bsd.gecko.mk to be the chosen backend.
# Users set ${WITH_GECKO} to the list of gecko backends they want on their
# system.

.if defined(USE_GECKO)
.if !defined(_POSTMKINCLUDED) && !defined(Gecko_Pre_Include)
Gecko_Pre_Include=	bsd.gecko.mk

# This file contains some reusable components for mozilla ports. It's of
# use primarily to apps from the mozilla project itself (such as Firefox,
# Thunderbird, etc.), and probably won't be of use for gecko-based ports
# like epiphany, galeon, etc.
#
# You need to make sure to add USE_GECKO=gecko to for your port can uses
# one of these options below.
#
# Ports can use the following:
#
# USE_MOZILLA			By default, it enables every system dependency
# 						listed in '_ALL_DEPENDS'. If your port doesn't
# 						need one of those then you can use '-' like
# 						'USE_MOZILLA= -png -vpx' to subtract the
# 						dependencies. Experimental deps use '+' like
# 						'USE_MOZILLA= +speex +theora'.
#
# MOZILLA_PLIST_DIRS	List of directories to descend into when installing
# 						and creating the plist
#
# MOZ_PIS_SCRIPTS		List of scripts residing in ${FILESDIR} to be
# 						filtered through MOZCONFIG_SED and installed along
# 						with our Pluggable Init Scripts (PIS)
#
# MOZ_SED_ARGS			sed(1) commands through which MOZ_PIS_SCRIPTS are
# 						filtered. There is a default set defined here, so
# 						you probably want to add to MOZ_SED_ARGS rather
# 						than clobber it
#
# MOZ_OPTIONS			configure arguments (added to .mozconfig). If
# 						NOMOZCONFIG is defined, you probably want to set
# 						CONFIGURE_ARGS+=${MOZ_OPTIONS}
#
# MOZ_MK_OPTIONS		The make(1) arguments (added to .mozconfig). If
# 						NOMOZCONFIG is defined, you probably want to set
# 						MAKE_ARGS+=${MOZ_MK_OPTIONS}
#
# MOZ_EXPORT			Environment variables for the build process (added
# 						to .mozconfig). If NOMOZCONFIG is defined, you
# 						probably want to set MAKE_ENV+=${MOZ_EXPORT}
#
# MOZ_CHROME			A variable for the --enable-chrome-format= in
# 						CONFIGURE_ARGS. The default is omni.
#
# MOZ_TOOLKIT			A variable for the --enable-default-toolkit= in
# 						CONFIGURE_ARGS. The default is cairo-gtk2.
#
# MOZ_EXTENSIONS		A list of extensions to build
#
# MOZ_PROTOCOLS			A list of protocols to build (http, ftp, etc.)
#
# PORT_MOZCONFIG		Defaults to ${FILESDIR}/mozconfig.in, but can be
# 						set to a generic mozconfig included with the port
#
# NOMOZCONFIG			Don't drop a customized .mozconfig into the build
# 						directory. Options will have to be specified in
# 						CONFIGURE_ARGS instead
#

MAINTAINER?=	gecko@FreeBSD.org

MOZILLA?=	${PORTNAME}
MOZILLA_VER?=	${PORTVERSION}
MOZILLA_BIN?=	${PORTNAME}-bin
MOZILLA_EXEC_NAME?=${MOZILLA}
MOZ_RPATH?=	${MOZILLA}
USES+=		cpe compiler:c++11-lib gmake iconv perl5 pkgconfig desktop-file-utils
CPE_VENDOR?=mozilla
USE_PERL5=	build
USE_XORG=	xext xrender xt

MOZILLA_SUFX?=	none
MOZSRC?=	${WRKSRC}
WRKSRC?=	${WRKDIR}/mozilla
PLISTD?=	${WRKDIR}/plist_dirs
PLISTF?=	${WRKDIR}/plist_files

MOZ_PIS_DIR?=		lib/${MOZILLA}/init.d

PORT_MOZCONFIG?=	${FILESDIR}/mozconfig.in
MOZCONFIG?=		${WRKSRC}/.mozconfig
MOZILLA_PLIST_DIRS?=	bin lib share/pixmaps share/applications
PKGINSTALL?=	${WRKDIR}/pkg-install
PKGDEINSTALL?=	${WRKDIR}/pkg-deinstall
PKGINSTALL_INC?=	${.CURDIR}/../../www/firefox/files/pkg-install.in
PKGDEINSTALL_INC?=	${.CURDIR}/../../www/firefox/files/pkg-deinstall.in

EXTRACT_AFTER_ARGS?=	--exclude */CVS/*	\
			--exclude */macbuild/*			\
			--exclude */package/*			\
			--exclude mozilla*/gc/boehm

MOZ_PKGCONFIG_FILES?=	${MOZILLA}-gtkmozembed ${MOZILLA}-js \
			${MOZILLA}-xpcom ${MOZILLA}-plugin

MOZ_EXPORT+=	${CONFIGURE_ENV} \
				PERL="${PERL}"
MOZ_OPTIONS+=	--prefix="${PREFIX}"

CPPFLAGS+=		-isystem${LOCALBASE}/include
LDFLAGS+=		-L${LOCALBASE}/lib -Wl,-rpath,${PREFIX}/lib/${MOZILLA}

# use jemalloc 3.0.0 API for stats/tuning
MOZ_EXPORT+=	MOZ_JEMALLOC3=1
.if ${OSVERSION} < 1000012
MOZ_OPTIONS+=	--enable-jemalloc
.endif

# Standard depends
_ALL_DEPENDS=	cairo event ffi graphite harfbuzz hunspell icu jpeg nspr nss opus png pixman soundtouch sqlite vorbis vpx

cairo_LIB_DEPENDS=	libcairo.so:${PORTSDIR}/graphics/cairo
cairo_MOZ_OPTIONS=	--enable-system-cairo
cairo_EXTRACT_AFTER_ARGS=	--exclude mozilla*/gfx/cairo/cairo

event_LIB_DEPENDS=	libevent.so:${PORTSDIR}/devel/libevent2
event_MOZ_OPTIONS=	--with-system-libevent
event_EXTRACT_AFTER_ARGS=	--exclude mozilla*/ipc/chromium/src/third_party/libevent

ffi_LIB_DEPENDS=	libffi.so:${PORTSDIR}/devel/libffi
ffi_MOZ_OPTIONS=	--enable-system-ffi
ffi_EXTRACT_AFTER_ARGS=	--exclude mozilla*/js/src/ctypes/libffi

.if exists(${FILESDIR}/patch-bug847568) || exists(${FILESDIR}/patch-z-bug847568)
graphite_LIB_DEPENDS=	libgraphite2.so:${PORTSDIR}/graphics/graphite2
graphite_MOZ_OPTIONS=	--with-system-graphite2
graphite_EXTRACT_AFTER_ARGS=	--exclude mozilla*/gfx/graphite2

harfbuzz_LIB_DEPENDS=	libharfbuzz.so:${PORTSDIR}/print/harfbuzz
harfbuzz_MOZ_OPTIONS=	--with-system-harfbuzz
harfbuzz_EXTRACT_AFTER_ARGS=	--exclude mozilla*/gfx/harfbuzz
.endif

hunspell_LIB_DEPENDS=	libhunspell-1.3.so:${PORTSDIR}/textproc/hunspell
hunspell_MOZ_OPTIONS=	--enable-system-hunspell

icu_LIB_DEPENDS=		libicui18n.so:${PORTSDIR}/devel/icu
icu_MOZ_OPTIONS=		--with-system-icu --with-intl-api --enable-intl-api

-jpeg_BUILD_DEPENDS=yasm:${PORTSDIR}/devel/yasm
# XXX depends on ports/180159 or package flavor support
#jpeg_LIB_DEPENDS=	libjpeg.so:${PORTSDIR}/graphics/libjpeg-turbo
jpeg_LIB_DEPENDS=	libjpeg.so:${PORTSDIR}/graphics/jpeg
jpeg_MOZ_OPTIONS=	--with-system-jpeg=${LOCALBASE}
jpeg_EXTRACT_AFTER_ARGS=	--exclude mozilla*/media/libjpeg

nspr_LIB_DEPENDS=	libnspr4.so:${PORTSDIR}/devel/nspr
nspr_MOZ_OPTIONS=	--with-system-nspr

nss_LIB_DEPENDS=	libnss3.so:${PORTSDIR}/security/nss
nss_MOZ_OPTIONS=	--with-system-nss
nss_EXTRACT_AFTER_ARGS=	--exclude mozilla*/dbm \
						--exclude mozilla*/security/coreconf \
						--exclude mozilla*/security/nss

.if exists(${FILESDIR}/patch-z-bug517422) || exists(${FILESDIR}/patch-zz-bug517422)
opus_LIB_DEPENDS=	libopus.so:${PORTSDIR}/audio/opus
opus_MOZ_OPTIONS=	--with-system-opus
opus_EXTRACT_AFTER_ARGS=	--exclude mozilla*/media/libopus
.endif

pixman_LIB_DEPENDS=	libpixman-1.so:${PORTSDIR}/x11/pixman
pixman_MOZ_OPTIONS=	--enable-system-pixman
pixman_EXTRACT_AFTER_ARGS=	--exclude mozilla*/gfx/cairo/libpixman

png_LIB_DEPENDS=	libpng15.so:${PORTSDIR}/graphics/png
png_MOZ_OPTIONS=	--with-system-png=${LOCALBASE}
#png_EXTRACT_AFTER_ARGS=	--exclude mozilla*/media/libpng

.if exists(${FILESDIR}/patch-z-bug517422) || exists(${FILESDIR}/patch-zz-bug517422)
soundtouch_LIB_DEPENDS=	libSoundTouch.so:${PORTSDIR}/audio/soundtouch
soundtouch_MOZ_OPTIONS=	--with-system-soundtouch
soundtouch_EXTRACT_AFTER_ARGS=	--exclude mozilla*/media/libsoundtouch

# XXX disabled: bug 913854 not yet upstreamed
speex_LIB_DEPENDS=	libspeexdsp.so:${PORTSDIR}/audio/speex
speex_MOZ_OPTIONS=	--with-system-speex
speex_EXTRACT_AFTER_ARGS=	--exclude mozilla*/media/libspeex_resampler
.endif

sqlite_LIB_DEPENDS=	libsqlite3.so:${PORTSDIR}/databases/sqlite3
sqlite_MOZ_OPTIONS=	--enable-system-sqlite
sqlite_EXTRACT_AFTER_ARGS=	--exclude mozilla*/db/sqlite3

.if exists(${FILESDIR}/patch-z-bug517422) || exists(${FILESDIR}/patch-zz-bug517422)
# XXX disabled: update to 1.2.x or review backported fixes
theora_LIB_DEPENDS=	libtheora.so:${PORTSDIR}/multimedia/libtheora
theora_MOZ_OPTIONS=	--with-system-theora
theora_EXTRACT_AFTER_ARGS=	--exclude mozilla*/media/libtheora

vorbis_LIB_DEPENDS=	libvorbis.so:${PORTSDIR}/audio/libvorbis
vorbis_MOZ_OPTIONS=	--with-system-vorbis --with-system-ogg
vorbis_EXTRACT_AFTER_ARGS=	--exclude mozilla*/media/libvorbis \
							--exclude mozilla*/media/libogg
.endif

-vpx_BUILD_DEPENDS=	yasm:${PORTSDIR}/devel/yasm
vpx_LIB_DEPENDS=	libvpx.so:${PORTSDIR}/multimedia/libvpx
vpx_MOZ_OPTIONS=	--with-system-libvpx
vpx_EXTRACT_AFTER_ARGS=	--exclude mozilla*/media/libvpx

.for use in ${USE_MOZILLA}
${use:S/-/_WITHOUT_/}=	${TRUE}
.endfor

.for dep in ${_ALL_DEPENDS} ${USE_MOZILLA:M+*:S/+//}
.if !defined(_WITHOUT_${dep})
BUILD_DEPENDS+=	${${dep}_BUILD_DEPENDS}
LIB_DEPENDS+=	${${dep}_LIB_DEPENDS}
RUN_DEPENDS+=	${${dep}_RUN_DEPENDS}
MOZ_OPTIONS+=	${${dep}_MOZ_OPTIONS}
EXTRACT_AFTER_ARGS+=	${${dep}_EXTRACT_AFTER_ARGS}
.else
BUILD_DEPENDS+=	${-${dep}_BUILD_DEPENDS}
.endif
.endfor

# Standard options
MOZ_CHROME?=	omni
MOZ_TOOLKIT?=	cairo-gtk2
MOZ_OPTIONS+=	\
		--enable-chrome-format=${MOZ_CHROME} \
		--enable-default-toolkit=${MOZ_TOOLKIT} \
		--with-pthreads
# Configure options for install
.if !defined(MOZ_EXTENSIONS)
MOZ_OPTIONS+=	--enable-extensions=default
.else
MOZ_OPTIONS+=	--enable-extensions=${MOZ_EXTENSIONS}
.endif
.if !defined(MOZ_PROTOCOLS)
MOZ_OPTIONS+=	--enable-necko-protocols=default
.else
MOZ_OPTIONS+=	--enable-necko-protocols=${MOZ_PROTOCOLS}
.endif
# others
MOZ_OPTIONS+=	--with-system-zlib		\
		--with-system-bz2		\
		--enable-unified-compilation	\
		--disable-debug-symbols		\
		--disable-glibtest		\
		--disable-gtktest		\
		--disable-freetypetest		\
		--disable-installer		\
		--disable-updater		\
		--disable-pedantic

# XXX stolen from www/chromium
MOZ_EXPORT+=	MOZ_GOOGLE_API_KEY=AIzaSyBsp9n41JLW8jCokwn7vhoaMejDFRd1mp8

.if ${PORT_OPTIONS:MGTK3}
MOZ_TOOLKIT=	cairo-gtk3
.endif

.if ${MOZ_TOOLKIT:Mcairo-qt}
# don't use - transparent backgrounds (bug 521582),
USE_MOZILLA+=	-cairo # ports/169343
USE_DISPLAY=yes # install
USE_GNOME+=	pango
. if ${MOZILLA_VER:R:R} >= 30
USE_QT5+=	qmake_build buildtools_build gui network quick printsupport
. else
USE_QT4+=	qmake_build moc_build rcc_build gui network opengl
. endif
MOZ_EXPORT+=	HOST_QMAKE="${QMAKE}" HOST_MOC="${MOC}" HOST_RCC="${RCC}"
.elif ${MOZ_TOOLKIT:Mcairo-gtk3}
USE_GNOME+=	gtk30
. if ${MOZILLA_VER:R:R} >= 32
USE_GNOME+= gtk20 # bug 624422
. endif
.else # gtk2, cairo-gtk2
USE_GNOME+=	gtk20
.endif

.if ${PORT_OPTIONS:MOPTIMIZED_CFLAGS}
CFLAGS+=		-O3
MOZ_EXPORT+=	MOZ_OPTIMIZE_FLAGS="${CFLAGS:M-O*}"
MOZ_OPTIONS+=	--enable-optimize
.else
MOZ_OPTIONS+=	--disable-optimize
.endif

.if ${PORT_OPTIONS:MDBUS}
BUILD_DEPENDS+=	libnotify>0:${PORTSDIR}/devel/libnotify
LIB_DEPENDS+=	libdbus-glib-1.so:${PORTSDIR}/devel/dbus-glib \
				libstartup-notification-1.so:${PORTSDIR}/x11/startup-notification
MOZ_OPTIONS+=	--enable-startup-notification
.else
MOZ_OPTIONS+=	--disable-dbus --disable-libnotify
.endif

.if ${PORT_OPTIONS:MGSTREAMER}
. if ${MOZILLA_VER:R:R} >= 30 || ${MOZILLA} == "seamonkey"
USE_GSTREAMER1?=good libav
MOZ_OPTIONS+=	--enable-gstreamer=1.0
. else
USE_GSTREAMER?=	good ffmpeg
MOZ_OPTIONS+=	--enable-gstreamer
. endif
.else
MOZ_OPTIONS+=	--disable-gstreamer
.endif

.if ${PORT_OPTIONS:MGCONF}
BUILD_DEPENDS+=	${gconf2_DETECT}:${gconf2_LIB_DEPENDS:C/.*://}
USE_GNOME+=		gconf2:build
MOZ_OPTIONS+=	--enable-gconf
.else
MOZ_OPTIONS+=	--disable-gconf
.endif

.if ${PORT_OPTIONS:MGIO} && ! ${MOZ_TOOLKIT:Mcairo-qt}
MOZ_OPTIONS+=	--enable-gio
.else
MOZ_OPTIONS+=	--disable-gio
.endif

.if ${PORT_OPTIONS:MGNOMEUI}
BUILD_DEPENDS+=	${libgnomeui_DETECT}:${libgnomeui_LIB_DEPENDS:C/.*://}
USE_GNOME+=		libgnomeui:build
MOZ_OPTIONS+=	--enable-gnomeui
.else
MOZ_OPTIONS+=	--disable-gnomeui
.endif

.if ${PORT_OPTIONS:MGNOMEVFS2}
BUILD_DEPENDS+=	${gnomevfs2_DETECT}:${gnomevfs2_LIB_DEPENDS:C/.*://}
USE_GNOME+=		gnomevfs2:build
MOZ_OPTIONS+=	--enable-gnomevfs
MOZ_OPTIONS:=	${MOZ_OPTIONS:C/(extensions)=(.*)/\1=\2,gnomevfs/}
.else
MOZ_OPTIONS+=	--disable-gnomevfs
.endif

.if ${PORT_OPTIONS:MLIBPROXY}
LIB_DEPENDS+=	libproxy.so:${PORTSDIR}/net/libproxy
MOZ_OPTIONS+=	--enable-libproxy
.else
MOZ_OPTIONS+=	--disable-libproxy
.endif

.if ${PORT_OPTIONS:MPGO}
USE_GCC?=	yes
USE_DISPLAY=yes

.undef GNU_CONFIGURE
MAKEFILE=	${WRKSRC}/client.mk
ALL_TARGET=	profiledbuild
MOZ_EXPORT+=MOZ_OPTIMIZE_FLAGS="-Os" MOZ_PGO_OPTIMIZE_FLAGS="${CFLAGS:M-O*}"
.endif

.if ${PORT_OPTIONS:MALSA}
LIB_DEPENDS+=	libasound.so:${PORTSDIR}/audio/alsa-lib
RUN_DEPENDS+=	${LOCALBASE}/lib/alsa-lib/libasound_module_pcm_oss.so:${PORTSDIR}/audio/alsa-plugins
MOZ_OPTIONS+=	--enable-alsa
.endif

.if ${PORT_OPTIONS:MPULSEAUDIO}
. if ${PORT_OPTIONS:MALSA}
BUILD_DEPENDS+=	pulseaudio>0:${PORTSDIR}/audio/pulseaudio
. else
# pull pulse package if we cannot fallback to another backend
LIB_DEPENDS+=	libpulse.so:${PORTSDIR}/audio/pulseaudio
. endif
MOZ_OPTIONS+=	--enable-pulseaudio
.else
MOZ_OPTIONS+=	--disable-pulseaudio
.endif

.if ${PORT_OPTIONS:MDEBUG}
MOZ_OPTIONS+=	--enable-debug --disable-release
STRIP=	# ports/184285
.else
MOZ_OPTIONS+=	--disable-debug --enable-release
.endif

.if ${PORT_OPTIONS:MDTRACE}
. if ${OSVERSION} < 1000510
BROKEN=			dtrace -G crashes with C++ object files
. endif
MOZ_OPTIONS+=	--enable-dtrace
LIBS+=			-lelf
STRIP=
.endif

.if ${PORT_OPTIONS:MLOGGING} || ${PORT_OPTIONS:MDEBUG}
MOZ_OPTIONS+=	--enable-logging
.else
MOZ_OPTIONS+=	--disable-logging
.endif

.if ${PORT_OPTIONS:MPROFILE}
MOZ_OPTIONS+=	--enable-profiling
STRIP=
.else
MOZ_OPTIONS+=	--disable-profiling
.endif

.if ${PORT_OPTIONS:MTEST}
USE_XORG+=		xscrnsaver
MOZ_OPTIONS+=	--enable-tests
.else
MOZ_OPTIONS+=	--disable-tests
.endif

.if !defined(STRIP) || ${STRIP} == ""
MOZ_OPTIONS+=	--disable-strip --disable-install-strip
.else
MOZ_OPTIONS+=	--enable-strip --enable-install-strip
.endif

# _MAKE_JOBS is only available after bsd.port.post.mk, thus cannot be
# used in .mozconfig. And client.mk automatically uses -jN where N
# is what multiprocessing.cpu_count() returns.
.if defined(MAKE_JOBS_NUMBER)
MOZ_MAKE_FLAGS+=-j${MAKE_JOBS_NUMBER}
.endif

.if defined(MOZ_MAKE_FLAGS)
MOZ_MK_OPTIONS+=MOZ_MAKE_FLAGS="${MOZ_MAKE_FLAGS}"
.endif

MOZ_SED_ARGS+=	-e's|@CPPFLAGS@|${CPPFLAGS}|g'		\
		-e 's|@CFLAGS@|${CFLAGS}|g'		\
		-e 's|@LDFLAGS@|${LDFLAGS}|g'		\
		-e 's|@LIBS@|${LIBS}|g'			\
		-e 's|@LOCALBASE@|${LOCALBASE}|g'	\
		-e 's|@PERL@|${PERL5}|g'			\
		-e 's|@MOZDIR@|${PREFIX}/lib/${MOZILLA}|g'	\
		-e 's|%%PREFIX%%|${PREFIX}|g'		\
		-e 's|%%CFLAGS%%|${CFLAGS}|g'		\
		-e 's|%%LDFLAGS%%|${LDFLAGS}|g'		\
		-e 's|%%LIBS%%|${LIBS}|g'		\
		-e 's|%%LOCALBASE%%|${LOCALBASE}|g'	\
		-e 's|%%PERL%%|${PERL5}|g'		\
		-e 's|%%MOZILLA%%|${MOZILLA}|g'		\
		-e 's|%%MOZILLA_BIN%%|${MOZILLA_BIN}|g'	\
		-e 's|%%MOZDIR%%|${PREFIX}/lib/${MOZILLA}|g'
MOZCONFIG_SED?= ${SED} ${MOZ_SED_ARGS}

.if ${ARCH} == amd64
CONFIGURE_TARGET=x86_64-unknown-${OPSYS:tl}${OSREL}
. if ${USE_MOZILLA:M-nss}
USE_BINUTILS=	# intel-gcm.s
CFLAGS+=	-B${LOCALBASE}/bin
LDFLAGS+=	-B${LOCALBASE}/bin
.  if ${OSVERSION} < 1000041 && exists(/usr/lib/libcxxrt.so) && \
	${CXXFLAGS:M-stdlib=libc++}
LIBS+=		-lcxxrt
.  endif
. endif
.elif ${ARCH:Mpowerpc*}
USE_GCC?=	yes
CFLAGS+=	-D__STDC_CONSTANT_MACROS
. if ${ARCH} == "powerpc64"
MOZ_EXPORT+=	UNAME_m="${ARCH}"
CFLAGS+=	-mminimal-toc
. endif
.elif ${ARCH} == "sparc64"
# Work around miscompilation/mislinkage of the sCanonicalVTable hacks.
MOZ_OPTIONS+=	--disable-v1-string-abi
.endif

.if defined(OBJDIR_BUILD)
CONFIGURE_SCRIPT=../configure

MOZ_OBJDIR=		${WRKSRC}/obj-${CONFIGURE_TARGET}
CONFIGURE_WRKSRC=${MOZ_OBJDIR}
BUILD_WRKSRC=	${MOZ_OBJDIR}
INSTALL_WRKSRC=	${MOZ_OBJDIR}
.else
MOZ_OBJDIR=		${WRKSRC}
.endif

.else # bsd.port.post.mk

pre-extract: gecko-pre-extract

gecko-pre-extract:
.if ${PORT_OPTIONS:MPGO}
	@${ECHO} "*****************************************************************"
	@${ECHO} "**************************** attention **************************"
	@${ECHO} "*****************************************************************"
	@${ECHO} "To build ${MOZILLA} with PGO support you need a running X server and"
	@${ECHO} "   build this port with an user who could access the X server!   "
	@${ECHO} ""
	@${ECHO} "During the build a ${MOZILLA} instance will start and run some test."
	@${ECHO} "      Do not interrupt or close ${MOZILLA} during this tests!       "
	@${ECHO} "*****************************************************************"
	@sleep 10
.endif

post-patch: gecko-post-patch gecko-moz-pis-patch

gecko-post-patch:
.if exists(${PKGINSTALL_INC})
	@${MOZCONFIG_SED} < ${PKGINSTALL_INC} > ${PKGINSTALL}
.endif
.if exists(${PKGDEINSTALL_INC})
	@${MOZCONFIG_SED} < ${PKGDEINSTALL_INC} > ${PKGDEINSTALL}
.endif
	@${RM} -f ${MOZCONFIG}
.if !defined(NOMOZCONFIG)
	@if [ -e ${PORT_MOZCONFIG} ] ; then \
		${MOZCONFIG_SED} < ${PORT_MOZCONFIG} >> ${MOZCONFIG} ; \
	fi
.for arg in ${MOZ_OPTIONS}
	@${ECHO_CMD} ac_add_options ${arg:Q} >> ${MOZCONFIG}
.endfor
.for arg in ${MOZ_MK_OPTIONS}
	@${ECHO_CMD} mk_add_options ${arg:Q} >> ${MOZCONFIG}
.endfor
.for var in ${MOZ_EXPORT}
	@${ECHO_CMD} export ${var:Q} >> ${MOZCONFIG}
.endfor
.endif # .if !defined(NOMOZCONFIG)
.if exists(${MOZSRC}/build/unix/mozilla-config.in)
	@${REINPLACE_CMD} -e  's/%{idldir}/%idldir%/g ; \
		s|"%FULL_NSPR_CFLAGS%"|`nspr-config --cflags`|g ; \
		s|"%FULL_NSPR_LIBS%"|`nspr-config --libs`|g' \
			${MOZSRC}/build/unix/mozilla-config.in
.endif
.if ${USE_MOZILLA:M-nspr}
	@${ECHO_MSG} "===>  Applying NSPR patches"
	@for i in ${.CURDIR}/../../devel/nspr/files/patch-*; do \
		${PATCH} ${PATCH_ARGS} -d ${MOZSRC}/nsprpub/build < $$i; \
	done
.endif
.if ${USE_MOZILLA:M-nss}
	@${ECHO_MSG} "===>  Applying NSS patches"
	@for i in ${.CURDIR}/../../security/nss/files/patch-*; do \
		${PATCH} ${PATCH_ARGS} -d ${MOZSRC}/security/nss < $$i; \
	done
.endif
	@for f in \
			${WRKSRC}/directory/c-sdk/config/FreeBSD.mk \
			${WRKSRC}/directory/c-sdk/configure \
			${MOZSRC}/security/coreconf/FreeBSD.mk \
			${MOZSRC}/js/src/Makefile.in \
			${MOZSRC}/js/src/configure \
			${MOZSRC}/configure \
			${WRKSRC}/configure; do \
		if [ -f $$f ] ; then \
			${REINPLACE_CMD} -Ee 's|-lc_r|${PTHREAD_LIBS}|g ; \
				s|-l?pthread|${PTHREAD_LIBS}|g ; \
				s|echo aout|echo elf|g ; \
				s|/usr/X11R6|${LOCALBASE}|g' \
				$$f; \
		fi; \
	done
	@if [ -f ${WRKSRC}/config/baseconfig.mk ] ; then \
		${REINPLACE_CMD} -e 's|%%MOZILLA%%|${MOZILLA}|g' \
			${WRKSRC}/config/baseconfig.mk; \
	else \
		${REINPLACE_CMD} -e 's|%%MOZILLA%%|${MOZILLA}|g' \
			${WRKSRC}/config/autoconf.mk.in; \
	fi
	@${REINPLACE_CMD} -e 's|%%PREFIX%%|${PREFIX}|g ; \
		s|%%LOCALBASE%%|${LOCALBASE}|g' \
			${MOZSRC}/build/unix/run-mozilla.sh
	@${REINPLACE_CMD} -e 's|/usr/local/netscape|${LOCALBASE}|g ; \
		s|/usr/local/lib/netscape|${LOCALBASE}/lib|g' \
		${MOZSRC}/xpcom/io/SpecialSystemDirectory.cpp
	@${REINPLACE_CMD} -e 's|/etc|${PREFIX}&|g' \
		${MOZSRC}/xpcom/build/nsXPCOMPrivate.h
	@${REINPLACE_CMD} -e 's|/usr/local|${LOCALBASE}|g' \
		-e 's|mozilla/plugins|browser_plugins|g' \
		-e 's|share/mozilla/extensions|lib/xpi|g' \
		${MOZSRC}/xpcom/io/nsAppFileLocationProvider.cpp \
		${MOZSRC}/toolkit/xre/nsXREDirProvider.cpp
	@${REINPLACE_CMD} -e 's|%%LOCALBASE%%|${LOCALBASE}|g' \
		${MOZSRC}/extensions/spellcheck/hunspell/src/mozHunspell.cpp

# handles mozilla pis scripts.
gecko-moz-pis-patch:
.for moz in ${MOZ_PIS_SCRIPTS}
	@${MOZCONFIG_SED} < ${FILESDIR}/${moz} > ${WRKDIR}/${moz}
.endfor

pre-configure: gecko-pre-configure

gecko-pre-configure:
.if defined(OBJDIR_BUILD)
	${MKDIR} ${MOZ_OBJDIR}
.endif

post-configure: gecko-post-configure

gecko-post-configure:
	@${ECHO_CMD} "#define JNIIMPORT" >> ${MOZSRC}/mozilla-config.h

pre-install: gecko-moz-pis-pre-install
post-install-script: gecko-create-plist

gecko-create-plist: port-post-install

.if !target(port-post-install)
port-post-install:
		@${DO_NADA}
.endif

gecko-create-plist:
# Create the plist
	${RM} -f ${PLISTF} ${PLISTD}
.for dir in ${MOZILLA_PLIST_DIRS}
	@cd ${STAGEDIR}${PREFIX}/${dir} && ${FIND} -H -s * ! -type d | \
		${SED} -e 's|^|${dir}/|' >> ${PLISTF} && \
		${FIND} -d * -type d | \
		${SED} -e 's|^|@dirrm ${dir}/|' >> ${PLISTD}
.endfor
	${CAT} ${PLISTF} | ${SORT} >> ${TMPPLIST}
	${CAT} ${PLISTD} | ${SORT} -r >> ${TMPPLIST}

gecko-moz-pis-pre-install:
.if defined(MOZ_PIS_SCRIPTS)
	${MKDIR} ${STAGEDIR}${PREFIX}/${MOZ_PIS_DIR}
.for moz in ${MOZ_PIS_SCRIPTS}
	${INSTALL_SCRIPT} ${WRKDIR}/${moz} ${STAGEDIR}${PREFIX}/${MOZ_PIS_DIR}
.endfor
.endif

.endif
.endif
# HERE THERE BE TACOS -- adamw
