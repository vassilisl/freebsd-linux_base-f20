# Created by: vassilis
# $FreeBSD$

PORTNAME=	pango
PORTVERSION=	1
CATEGORIES=	x11-toolkits linux
MASTER_SITES=		http://archives.fedoraproject.org/pub/fedora/linux/releases/${LINUX_RPM_VERSION}/Everything/${LINUX_CPU_ARCH}/os/Packages/
PKGNAMEPREFIX=	linux-f20-
DISTFILES=	${BIN_DISTFILES}
EXTRACT_ONLY=		${DISTFILES} ${DISTFILES_DEPS}

MAINTAINER=	vassilis@einval.com
COMMENT=	System for layout and rendering of internationalized text (Linux Fedora 20)

BIN_DISTFILES=	\
			p/pango-1.36.1-1.fc${LINUX_RPM_VERSION}.${LINUX_RPM_ARCH}.rpm

ONLY_FOR_ARCHS=	i386 amd64
LINUX_CPU_ARCH=		i386
LINUX_RPM_ARCH=		i686
LINUX_RPM_VERSION=	20
USE_LINUX_PREFIX=	yes
NO_WRKSUBDIR=		yes
DISTINFO_FILE?=		${MASTERDIR}/distinfo.${LINUX_RPM_ARCH}
RUN_DEPENDS=		/compat/linux/usr/lib/libX11.so.6:${PORTSDIR}/x11/linux-f20-xorg-libs \
					/compat/linux/usr/lib/libcairo.so.2:${PORTSDIR}/graphics/linux-f20-cairo \
					/compat/linux/usr/lib/libharfbuzz.so.0:${PORTSDIR}/print/linux-f20-harfbuzz \
					/compat/linux/usr/lib/libthai.so.0:${PORTSDIR}/devel/linux-f20-libthai

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
