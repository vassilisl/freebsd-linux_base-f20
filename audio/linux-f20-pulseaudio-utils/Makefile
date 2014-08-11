# Created by: vassilisl
# $FreeBSD$

PORTNAME=	pulseaudio-utils
PORTVERSION=	1
CATEGORIES=	audio linux
MASTER_SITES=		http://archives.fedoraproject.org/pub/fedora/linux/releases/${LINUX_RPM_VERSION}/Everything/${LINUX_CPU_ARCH}/os/Packages/
PKGNAMEPREFIX=	linux-f20-
DISTFILES=	${BIN_DISTFILES}
DIST_SUBDIR=		rpm/${LINUX_RPM_ARCH}/fedora/${LINUX_RPM_VERSION}
EXTRACT_ONLY=		${BIN_DISTFILES}

MAINTAINER=	vassilis@einval.com
COMMENT=	RPM with PulseAudio sound server utilities (Linux Fedora 20)

BIN_DISTFILES=	\
			p/pulseaudio-utils-4.0-8.gitf81e3.fc${LINUX_RPM_VERSION}.${LINUX_RPM_ARCH}.rpm

ONLY_FOR_ARCHS=	i386 amd64
LINUX_CPU_ARCH=		i386
LINUX_RPM_ARCH=		i686
LINUX_RPM_VERSION=	20
USE_LINUX_PREFIX=	yes
NO_WRKSUBDIR=		yes
DISTINFO_FILE?=		${MASTERDIR}/distinfo.${LINUX_RPM_ARCH}
RUN_DEPENDS=	${PREFIX}/usr/lib/libpulse.so.0:${PORTSDIR}/audio/linux-f20-pulseaudio-libs

EXTRACT_CMD?=		${TAR}
EXTRACT_BEFORE_ARGS?=	-xPf
EXTRACT_AFTER_ARGS?=

do-build:

do-install:
	@cd ${WRKSRC} && ${FIND} * ! -path "stage*" -type d -exec ${MKDIR} "${STAGEDIR}${PREFIX}/{}" \;
	@cd ${WRKSRC} && ${FIND} * ! -path "stage/*" ! -type d \
		| ${CPIO} -pm -R root:wheel ${STAGEDIR}${PREFIX}

USE_LDCONFIG=	yes
USE_LINUX_RPM=	yes

BRANDELF_FILES=	usr/bin/pacat \
				usr/bin/pacmd \
				usr/bin/pactl \
				usr/bin/padsp \
				usr/bin/pamon \
				usr/bin/paplay \
				usr/bin/parec \
				usr/bin/parecord \
				usr/bin/pasuspender \
				usr/bin/pax11publish

.include <bsd.port.mk>
