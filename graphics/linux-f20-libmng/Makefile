# Created by: vassilisl
# $FreeBSD$

PORTNAME=	libmng
PORTVERSION=	1
CATEGORIES=	graphics linux
MASTER_SITES=		http://archives.fedoraproject.org/pub/fedora/linux/releases/${LINUX_RPM_VERSION}/Everything/${LINUX_CPU_ARCH}/os/Packages/
PKGNAMEPREFIX=	linux-f20-
DISTFILES=	${BIN_DISTFILES}

MAINTAINER=	vassilis@einval.com
COMMENT=	Library for Multiple-image Network Graphics support (Linux Fedora 20)

BIN_DISTFILES=	\
			l/libmng-1.0.10-12.fc${LINUX_RPM_VERSION}.${LINUX_RPM_ARCH}.rpm

ONLY_FOR_ARCHS=	i386 amd64
LINUX_CPU_ARCH=		i386
LINUX_RPM_ARCH=		i686
LINUX_RPM_VERSION=	20
USE_LINUX_PREFIX=	yes
USE_LINUX=			f20
NO_WRKSUBDIR=		yes
DISTINFO_FILE?=		${MASTERDIR}/distinfo.${LINUX_RPM_ARCH}
RUN_DEPENDS=		/compat/linux/lib/libc.so.6:${PORTSDIR}/emulators/linux_base-f20 \
					/compat/linux/usr/lib/libjpeg.so.62:${PORTSDIR}/graphics/linux-f20-libjpeg-turbo \
					/compat/linux/usr/lib/liblcms.so.1:${PORTSDIR}/graphics/linux-f20-lcms-libs

CONFLICTS=			linux-f10-libmng-[0-9]*

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
