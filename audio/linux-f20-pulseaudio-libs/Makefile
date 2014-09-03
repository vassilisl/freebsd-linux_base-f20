# Created by: vassilisl
# $FreeBSD$

PORTNAME=	pulseaudio-libs
PORTVERSION=	1
CATEGORIES=	audio linux
MASTER_SITES=		http://archives.fedoraproject.org/pub/fedora/linux/releases/${LINUX_RPM_VERSION}/Everything/${LINUX_CPU_ARCH}/os/Packages/
PKGNAMEPREFIX=	linux-f20-
DISTFILES=	${BIN_DISTFILES}
DIST_SUBDIR=		rpm/${LINUX_RPM_ARCH}/fedora/${LINUX_RPM_VERSION}
EXTRACT_ONLY=		${BIN_DISTFILES}

MAINTAINER=	vassilis@einval.com
COMMENT=	Libraries for PulseAudio clients (Linux Fedora 20)

BIN_DISTFILES=	\
			p/pulseaudio-libs-4.0-8.gitf81e3.fc${LINUX_RPM_VERSION}.${LINUX_RPM_ARCH}.rpm

ONLY_FOR_ARCHS=	i386 amd64
LINUX_CPU_ARCH=		i386
LINUX_RPM_ARCH=		i686
LINUX_RPM_VERSION=	20
USE_LINUX_PREFIX=	yes
NO_WRKSUBDIR=		yes
DISTINFO_FILE?=		${MASTERDIR}/distinfo.${LINUX_RPM_ARCH}
RUN_DEPENDS=	${LOCALBASE}/bin/pulseaudio:${PORTSDIR}/audio/pulseaudio \
				/compat/linux/usr/lib/libsndfile.so.1:${PORTSDIR}/audio/linux-f20-libsndfile \
				/compat/linux/usr/lib/libasyncns.so.0:${PORTSDIR}/dns/linux-f20-libasyncns \
				/compat/linux/usr/lib/libwrap.so.0:${PORTSDIR}/devel/linux-f20-tcp_wrappers-libs \
				/compat/linux/usr/lib/libjson-c.so.2:${PORTSDIR}/devel/linux-f20-jsonc-libs \
				/compat/linux/usr/lib/libX11.so.6:${PORTSDIR}/x11/linux-f20-xorg-libs \
				/compat/linux/usr/lib/libdbus-1.so.3:${PORTSDIR}/devel/linux-f20-dbus-libs


CONFLICTS=		linux-f10-pulseaudio-libs-[0-9]

EXTRACT_CMD?=		${TAR}
EXTRACT_BEFORE_ARGS?=	-xPf
EXTRACT_AFTER_ARGS?=

do-build:

do-install:
	@cd ${WRKSRC} && ${FIND} * ! -path "stage*" -type d -exec ${MKDIR} "${STAGEDIR}${PREFIX}/{}" \;
	@cd ${WRKSRC} && ${FIND} * ! -path "stage/*" ! -type d \
		| ${CPIO} -pm -R root:wheel ${STAGEDIR}${PREFIX}

USE_LDCONFIG=	yes

.include <bsd.port.mk>
