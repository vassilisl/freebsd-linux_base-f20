# Created by: Vassilis
# $FreeBSD:$

PORTNAME=	qt4-webkit
PORTVERSION=	1
CATEGORIES=	www linux
MASTER_SITES=		http://archives.fedoraproject.org/pub/fedora/linux/releases/${LINUX_RPM_VERSION}/Everything/${LINUX_CPU_ARCH}/os/Packages/
PKGNAMEPREFIX=	linux-f20-
DISTFILES=	${BIN_DISTFILES}
EXTRACT_ONLY=		${DISTFILES} ${DISTFILES_DEPS}

MAINTAINER=	vassilis@einval.com
COMMENT=	RPM of QT4 WebKit libs (Linux Fedora 20)

BIN_DISTFILES=	\
			q/qtwebkit-2.3.3-1.fc${LINUX_RPM_VERSION}.${LINUX_RPM_ARCH}.rpm

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
RUN_DEPENDS=		/compat/linux/usr/lib/libQtSensors.so.1:${PORTSDIR}/x11-toolkits/linux-f20-qt-mobility \
					/compat/linux/usr/lib/libgstapp-0.10.so.0:${PORTSDIR}/multimedia/linux-f20-gstreamer-plugins-base \
					/compat/linux/usr/lib/libwebp.so.4:${PORTSDIR}/graphics/linux-f20-libwebp \
					/compat/linux/usr/lib/libxslt.so.1:${PORTSDIR}/devel/linux-f20-libxslt

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
