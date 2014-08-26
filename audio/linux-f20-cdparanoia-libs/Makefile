# Created by: vassilisl
# $FreeBSD$

PORTNAME=	cdparanoia-libs
PORTVERSION=	1
CATEGORIES=	audio linux
MASTER_SITES=		http://archives.fedoraproject.org/pub/fedora/linux/releases/${LINUX_RPM_VERSION}/Everything/${LINUX_CPU_ARCH}/os/Packages/
PKGNAMEPREFIX=	linux-f20-
DISTFILES=	${BIN_DISTFILES}
DIST_SUBDIR=		rpm/${LINUX_RPM_ARCH}/fedora/${LINUX_RPM_VERSION}
EXTRACT_ONLY=		${BIN_DISTFILES}

MAINTAINER=	vassilis@einval.com
COMMENT=	Libraries for libcdda_paranoia (Paranoia III) (Linux Fedora 20)

RUN_DEPENDS=		/compat/linux/lib/libc.so.6:${PORTSDIR}/emulators/linux_base-f20

BIN_DISTFILES=	\
			c/cdparanoia-libs-10.2-14.fc${LINUX_RPM_VERSION}.${LINUX_RPM_ARCH}.rpm

ONLY_FOR_ARCHS=	i386 amd64
LINUX_CPU_ARCH=		i386
LINUX_RPM_ARCH=		i686
LINUX_RPM_VERSION=	20
USE_LINUX_PREFIX=	yes
NO_WRKSUBDIR=		yes
DISTINFO_FILE?=		${MASTERDIR}/distinfo.${LINUX_RPM_ARCH}

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
