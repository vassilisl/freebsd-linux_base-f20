# Created by: Vassilis
# $FreeBSD:$

PORTNAME=	qt4-gui
PORTVERSION=	1
CATEGORIES=	x11-toolkits linux
MASTER_SITES=		http://archives.fedoraproject.org/pub/fedora/linux/releases/${LINUX_RPM_VERSION}/Everything/${LINUX_CPU_ARCH}/os/Packages/
PKGNAMEPREFIX=	linux-f20-
EXTRACT_ONLY=		${DISTFILES} ${DISTFILES_DEPS}
DISTFILES=	${BIN_DISTFILES}

MAINTAINER=	vassilis@einval.com
COMMENT=	RPM of QT4 X11 GUI libs (Linux Fedora 20)

BIN_DISTFILES=	\
			q/qt-x11-4.8.5-10.fc${LINUX_RPM_VERSION}.${LINUX_RPM_ARCH}.rpm

# This probably should be in the USE_LINUX_APPS; waiting for modular support of linux_base
# of the user's choice in /usr/ports/Mk/bsd.linux-apps.mk
DISTFILES_DEPS=	\

ONLY_FOR_ARCHS=	i386 amd64
LINUX_CPU_ARCH=		i386
LINUX_RPM_ARCH=		i686
LINUX_RPM_VERSION=	20
USE_LINUX_PREFIX=	yes
USE_LINUX=			f20
NO_WRKSUBDIR=		yes
DISTINFO_FILE?=		${MASTERDIR}/distinfo.${LINUX_RPM_ARCH}
RUN_DEPENDS=		/compat/linux/lib/libasound.so.2:${PORTSDIR}/audio/linux-f20-alsa-lib \
					/compat/linux/usr/lib/libjpeg.so.62:${PORTSDIR}/graphics/linux-f20-libjpeg-turbo \
					/compat/linux/usr/lib/libpng16.so.16:${PORTSDIR}/graphics/linux-f20-libpng \
					/compat/linux/usr/lib/libtiff.so.5:${PORTSDIR}/graphics/linux-f20-libtiff \
					/compat/linux/usr/lib/libjbig.so.2.0:${PORTSDIR}/graphics/linux-f20-jbigkit-libs \
					/compat/linux/usr/lib/libQtCore.so.4:${PORTSDIR}/x11-toolkits/linux-f20-qt4

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
