# Created by: vassilis
# $FreeBSD$

PORTNAME=	alsa-utils
PORTVERSION=	1
CATEGORIES=	audio linux
MASTER_SITES=		http://archives.fedoraproject.org/pub/fedora/linux/releases/${LINUX_RPM_VERSION}/Everything/${LINUX_CPU_ARCH}/os/Packages/
PKGNAMEPREFIX=	linux-f20-
DIST_SUBDIR=		rpm/${LINUX_RPM_ARCH}/fedora/${LINUX_RPM_VERSION}
EXTRACT_ONLY=		${BIN_DISTFILES}

MAINTAINER=	vassilis@einval.com
COMMENT=	RPM of Advanced Linux Sound Architecture utils (Linux Fedora 20)

DISTFILES=	\
			a/alsa-utils-1.0.27.2-3.fc${LINUX_RPM_VERSION}.${LINUX_RPM_ARCH}.rpm

CONFLICTS=	linux-f10-alsa-utils-[0-9]*

ONLY_FOR_ARCHS=	i386 amd64
LINUX_CPU_ARCH=		i386
LINUX_RPM_ARCH=		i686
LINUX_RPM_VERSION=	20
USE_LINUX_PREFIX=	yes
NO_WRKSUBDIR=		yes
DISTINFO_FILE?=		${MASTERDIR}/distinfo.${LINUX_RPM_ARCH}
RUN_DEPENDS=		/compat/linux/usr/lib/libasound.so.2:${PORTSDIR}/audio/linux-f20-alsa-lib \
					/compat/linux/usr/lib/libsamplerate.so.0:${PORTSDIR}/audio/linux-f20-libsamplerate

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
