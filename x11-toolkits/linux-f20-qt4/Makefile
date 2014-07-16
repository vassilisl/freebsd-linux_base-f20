# Created by: Vassilis
# $FreeBSD:$

PORTNAME=	qt4
PORTVERSION=	1
CATEGORIES=	x11-toolkits linux
MASTER_SITES=		http://archives.fedoraproject.org/pub/fedora/linux/releases/${DISTVERSION}/Everything/${LINUX_CPU_ARCH}/os/Packages/
PKGNAMEPREFIX=	linux-f20-
DISTVERSION=	20
EXTRACT_ONLY=		${DISTFILES} ${DISTFILES_DEPS}

DISTFILES=	\
			q/qt-4.8.5-10.fc${DISTVERSION}.${LINUX_RPM_ARCH}.rpm

# This probably should be in the USE_LINUX_APPS; waiting for modular support of linux_base
# of the user's choice in /usr/ports/Mk/bsd.linux-apps.mk
DISTFILES_DEPS=	\
		#f/fontconfig-2.11.0-1.fc${DISTVERSION}.${LINUX_RPM_ARCH}.rpm
#l/libmng-1.0.10-12.fc${DISTVERSION}.${LINUX_RPM_ARCH}.rpm

ONLY_FOR_ARCHS=	i386 amd64
LINUX_CPU_ARCH=		i386
LINUX_RPM_ARCH=		i686
USE_LINUX_PREFIX=	yes
USE_LINUX=			f20
NO_WRKSUBDIR=		yes
DISTINFO_FILE?=		${MASTERDIR}/distinfo.${LINUX_RPM_ARCH}

MAINTAINER=	emulation@FreeBSD.org
COMMENT=	RPM of QT4 (Linux Fedora 20)

EXTRACT_CMD?=		${TAR}
EXTRACT_BEFORE_ARGS?=	-xPf
EXTRACT_AFTER_ARGS?=

do-build:

do-install:
	@cd ${WRKSRC} && ${FIND} * ! -path "stage*" -type d -exec ${MKDIR} "${STAGEDIR}${PREFIX}/{}" \;
	@cd ${WRKSRC} && ${FIND} * ! -path "stage/*" ! -type d \
		| ${CPIO} -pm -R root:wheel ${STAGEDIR}${PREFIX}
#
#USE_LINUX_APPS=	fontconfig libmng png
USE_LDCONFIG=		yes

.include <bsd.port.mk>
