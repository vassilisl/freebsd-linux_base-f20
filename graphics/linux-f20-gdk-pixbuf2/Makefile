# Created by: vassilis
# $FreeBSD$

PORTNAME=	gdk-pixbuf2
PORTVERSION=	1
CATEGORIES=	graphics linux
MASTER_SITES=		http://archives.fedoraproject.org/pub/fedora/linux/releases/${LINUX_RPM_VERSION}/Everything/${LINUX_CPU_ARCH}/os/Packages/
PKGNAMEPREFIX=	linux-f20-
DISTFILES=	${BIN_DISTFILES}

MAINTAINER=	vassilis@einval.com
COMMENT=	RPM of an image loading library (Linux Fedora 20)

BIN_DISTFILES=	\
			g/gdk-pixbuf2-2.30.1-1.fc${LINUX_RPM_VERSION}.${LINUX_RPM_ARCH}.rpm

ONLY_FOR_ARCHS=	i386 amd64
LINUX_CPU_ARCH=		i386
LINUX_RPM_ARCH=		i686
LINUX_RPM_VERSION=	20
USE_LINUX_PREFIX=	yes
NO_WRKSUBDIR=		yes
DISTINFO_FILE?=		${MASTERDIR}/distinfo.${LINUX_RPM_ARCH}
RUN_DEPENDS=		/compat/linux/usr/lib/libjasper.so.1:${PORTSDIR}/graphics/linux-f20-jasper-libs \
					/compat/linux/usr/lib/libpng16.so.16:${PORTSDIR}/graphics/linux-f20-libpng \
					/compat/linux/usr/lib/libtiff.so.5:${PORTSDIR}/graphics/linux-f20-libtiff \
					/compat/linux/usr/lib/libjbig.so.2.0:${PORTSDIR}/graphics/linux-f20-jbigkit-libs \
					/compat/linux/usr/share/mime/packages/freedesktop.org.xml:${PORTSDIR}/misc/linux-f20-shared-mime-info

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
