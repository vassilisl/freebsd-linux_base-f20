# Created by: Vassilis based on the F10 by bsam
# $FreeBSD$

PORTNAME=	png
PORTVERSION=	1
DISTVERSION=	20
CATEGORIES=	graphics linux
MASTER_SITES=		http://archives.fedoraproject.org/pub/fedora/linux/releases/${DISTVERSION}/Everything/${LINUX_CPU_ARCH}/os/Packages/
PKGNAMEPREFIX=	linux-f20-

DISTFILES=	\
			l/libpng-1.6.3-3.fc${DISTVERSION}.${LINUX_RPM_ARCH}.rpm

MAINTAINER=	emulation@FreeBSD.org
COMMENT=	RPM of the png lib (Linux Fedora 20)

CONFLICTS=	linux-png-[0-9]* linux-f8-png-[0-9]*

ONLY_FOR_ARCHS=	i386 amd64
LINUX_CPU_ARCH=		i386
LINUX_RPM_ARCH=		i686
USE_LINUX_PREFIX=	yes
USE_LINUX=			f20
NO_WRKSUBDIR=		yes
DISTINFO_FILE?=		${MASTERDIR}/distinfo.${LINUX_RPM_ARCH}

MAINTAINER=	emulation@FreeBSD.org
COMMENT=	RPM of png libs (Linux Fedora 20)

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
