# Created by: vassilisl
# $FreeBSD$

PORTNAME=	gtk2
PORTVERSION=	1
CATEGORIES=	x11-toolkits linux
MASTER_SITES=		http://archives.fedoraproject.org/pub/fedora/linux/releases/${LINUX_RPM_VERSION}/Everything/${LINUX_CPU_ARCH}/os/Packages/
PKGNAMEPREFIX=	linux-f20-
DISTFILES=	${BIN_DISTFILES}
EXTRACT_ONLY=		${DISTFILES} ${DISTFILES_DEPS}

MAINTAINER=	vassilis@einval.com
COMMENT=	RPM of the GIMP ToolKit (GTK+), a library for creating GUIs for X (Linux Fedora 20)

BIN_DISTFILES=	\
			g/gtk2-2.24.22-2.fc${LINUX_RPM_VERSION}.${LINUX_RPM_ARCH}.rpm

ONLY_FOR_ARCHS=	i386 amd64
LINUX_CPU_ARCH=		i386
LINUX_RPM_ARCH=		i686
LINUX_RPM_VERSION=	20
USE_LINUX_PREFIX=	yes
NO_WRKSUBDIR=		yes
DISTINFO_FILE?=		${MASTERDIR}/distinfo.${LINUX_RPM_ARCH}
RUN_DEPENDS=		/compat/linux/usr/lib/libX11.so.6:${PORTSDIR}/x11/linux-f20-xorg-libs \
					/compat/linux/usr/lib/libatk-1.0.so.0:${PORTSDIR}/accessibility/linux-f20-atk \
					/compat/linux/usr/lib/libpango-1.0.so.0:${PORTSDIR}/x11-toolkits/linux-f20-pango \
					/compat/linux/usr/lib/libtiff.so.5:${PORTSDIR}/graphics/linux-f20-libtiff \
					/compat/linux/usr/lib/libcups.so.2:${PORTSDIR}/print/linux-f20-cups-libs \
					/compat/linux/usr/lib/libgdk_pixbuf-2.0.so.0:${PORTSDIR}/graphics/linux-f20-gdk-pixbuf2


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
