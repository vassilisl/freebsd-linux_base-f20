# Created by: Vassilis
# $FreeBSD:$

PORTNAME=	gstreamer-plugin-base
PORTVERSION=	1
CATEGORIES=	multimedia linux
MASTER_SITES=		http://archives.fedoraproject.org/pub/fedora/linux/releases/${LINUX_RPM_VERSION}/Everything/${LINUX_CPU_ARCH}/os/Packages/
PKGNAMEPREFIX=	linux-f20-
DISTFILES=	${BIN_DISTFILES}
EXTRACT_ONLY=		${DISTFILES} ${DISTFILES_DEPS}

MAINTAINER=	vassilis@einval.com
COMMENT=	RPM of GStreamer Plugins Base (Linux Fedora 20)

BIN_DISTFILES=	\
			g/gstreamer-plugins-base-0.10.36-6.fc${LINUX_RPM_VERSION}.${LINUX_RPM_ARCH}.rpm

# This probably should be in the USE_LINUX_APPS; waiting for modular support of linux_base
# of the user's choice in /usr/ports/Mk/bsd.linux-apps.mk
DISTFILES_DEPS=	\

ONLY_FOR_ARCHS=	i386 amd64
LINUX_CPU_ARCH=		i386
LINUX_RPM_ARCH=		i686
LINUX_RPM_VERSION=	20
USE_LINUX_PREFIX=	yes
USE_LINUX=			f20
NO_WRKSUBDIR=		yes
DISTINFO_FILE?=		${MASTERDIR}/distinfo.${LINUX_RPM_ARCH}
RUN_DEPENDS=		/compat/linux/usr/lib/libgstreamer-0.10.so.0:${PORTSDIR}/multimedia/linux-f20-gstreamer \
					/compat/linux/usr/lib/libvisual-0.4.so.0:${PORTSDIR}/multimedia/linux-f20-libvisual \
					/compat/linux/usr/lib/libvorbis.so.0:${PORTSDIR}/audio/linux-f20-libvorbis \
					/compat/linux/usr/lib/libpango-1.0.so.0:${PORTSDIR}/x11-toolkits/linux-f20-pango \
					/compat/linux/usr/lib/libcairo.so.2:${PORTSDIR}/graphics/linux-f20-cairo \
					/compat/linux/lib/libasound.so.2:${PORTSDIR}/audio/linux-f20-alsa-lib \
					/compat/linux/lib/usr/lib/liborc-0.4.so.0:${PORTSDIR}./devel/linux-f20-orc \
					/compat/linux/usr/lib/libxml2.so.2:${PORTSDIR}/devel/linux-f20-libxml2 \
					/compat/linux/usr/lib/libtheoradec.so.1:${PORTDIR}/multimedia/linux-f20-libtheora \
					/compat/linux/usr/lib/libcdda_paranoia.so.0:${PORTSDIR}/audio/linux-f20-cdparanoia-libs


EXTRACT_CMD?=		${TAR}
EXTRACT_BEFORE_ARGS?=	-xPf
EXTRACT_AFTER_ARGS?=

do-build:

do-install:
	@cd ${WRKSRC} && ${FIND} * ! -path "stage*" -type d -exec ${MKDIR} "${STAGEDIR}${PREFIX}/{}" \;
	@cd ${WRKSRC} && ${FIND} * ! -path "stage/*" ! -type d \
		| ${CPIO} -pm -R root:wheel ${STAGEDIR}${PREFIX}

USE_LDCONFIG=		yes

.include <bsd.port.mk>
