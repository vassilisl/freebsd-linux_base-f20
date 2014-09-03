# Created by: vassilisl
# $FreeBSD$

PORTNAME=	fontconfig
PORTVERSION=	1
CATEGORIES=	x11-fonts linux
MASTER_SITES=		http://archives.fedoraproject.org/pub/fedora/linux/releases/${LINUX_RPM_VERSION}/Everything/${LINUX_CPU_ARCH}/os/Packages/
PKGNAMEPREFIX=	linux-f20-
DISTFILES=	${BIN_DISTFILES}

MAINTAINER=	vassilis@einval.com
COMMENT=	RPM of Font configuration and customization library (Linux Fedora 20)

BIN_DISTFILES=	\
			f/fontconfig-2.11.0-1.fc${LINUX_RPM_VERSION}.${LINUX_RPM_ARCH}.rpm

ONLY_FOR_ARCHS=	i386 amd64
LINUX_CPU_ARCH=		i386
LINUX_RPM_ARCH=		i686
LINUX_RPM_VERSION=	20
USE_LINUX_PREFIX=	yes
NO_WRKSUBDIR=		yes
DISTINFO_FILE?=		${MASTERDIR}/distinfo.${LINUX_RPM_ARCH}
RUN_DEPENDS=        /compat/linux/usr/lib/libexpat.so.1:${PORTSDIR}/devel/linux-f20-expat \
					/compat/linux/usr/lib/libfreetype.so.6:${PORTSDIR}/emulators/linux_base-f20 \
					/compat/linux/usr/share/fontconfig/conf.avail:${PORTSDIR}/x11-fonts/linux-f20-fontpackages-filesystem

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
