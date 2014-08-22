# Created by: vassilisl
# $FreeBSD$

PORTNAME=	libsndfile
PORTVERSION=	1
CATEGORIES=	devel linux
MASTER_SITES=		http://archives.fedoraproject.org/pub/fedora/linux/releases/${LINUX_RPM_VERSION}/Everything/${LINUX_CPU_ARCH}/os/Packages/
PKGNAMEPREFIX=	linux-f20-
DISTFILES=	${BIN_DISTFILES}

MAINTAINER=	vassilis@einval.com
COMMENT=	Library for reading and writing sound files (Linux Fedora 20)

BIN_DISTFILES=	\
			l/libsndfile-1.0.25-8.fc${LINUX_RPM_VERSION}.${LINUX_RPM_ARCH}.rpm

ONLY_FOR_ARCHS=	i386 amd64
LINUX_CPU_ARCH=		i386
LINUX_RPM_ARCH=		i686
LINUX_RPM_VERSION=	20
USE_LINUX_PREFIX=	yes
USE_LINUX=			f20
NO_WRKSUBDIR=		yes
DISTINFO_FILE?=		${MASTERDIR}/distinfo.${LINUX_RPM_ARCH}
RUN_DEPENDS=		/compat/linux/usr/lib/libFLAC.so.8:${PORTSDIR}/audio/linux-f20-flac-libs \
					/compat/linux/usr/lib/libgsm.so.1:${PORTSDIR}/audio/linux-f20-libgsm \
					/compat/linux/usr/lib/libogg.so.0:${PORTSDIR}/audio/linux-f20-libogg \
					/compat/linux/usr/lib/libvorbis.so.0:${PORTSDIR}/audio/linux-f20-libvorbis

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
