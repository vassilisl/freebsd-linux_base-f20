# Created by: Vassilis
# $FreeBSD:$

PORTNAME=	qt4
PORTVERSION=	1
CATEGORIES=	x11-toolkits linux
MASTER_SITES=		http://archives.fedoraproject.org/pub/fedora/linux/releases/${LINUX_RPM_VERSION}/Everything/${LINUX_CPU_ARCH}/os/Packages/
PKGNAMEPREFIX=	linux-f20-
DISTFILES=	${BIN_DISTFILES}
EXTRACT_ONLY=		${DISTFILES} ${DISTFILES_DEPS}

MAINTAINER=	vassilis@einval.com
COMMENT=	RPM of QT4 (Linux Fedora 20)

BIN_DISTFILES=	\
			q/qt-4.8.5-10.fc${LINUX_RPM_VERSION}.${LINUX_RPM_ARCH}.rpm

# This probably should be in the USE_LINUX_APPS; waiting for modular support of linux_base
# of the user's choice in /usr/ports/Mk/bsd.linux-apps.mk
DISTFILES_DEPS=	\
		#f/fontconfig-2.11.0-1.fc${LINUX_RPM_VERSION}.${LINUX_RPM_ARCH}.rpm

ONLY_FOR_ARCHS=	i386 amd64
LINUX_CPU_ARCH=		i386
LINUX_RPM_ARCH=		i686
LINUX_RPM_VERSION=	20
USE_LINUX_PREFIX=	yes
USE_LINUX=			f20
NO_WRKSUBDIR=		yes
DISTINFO_FILE?=		${MASTERDIR}/distinfo.${LINUX_RPM_ARCH}
RUN_DEPENDS=		/compat/linux/usr/bin/update-ca-trust:${PORTSDIR}/security/linux-f20-ca-certificates \
					/compat/linux/lib/libdbus-1.so.3:${PORTSDIR}/devel/linux-f20-dbus-libs \
					/compat/linux/usr/lib/libcrypto.so.10:${PORTSDIR}/security/linux-f20-openssl-libs \
					/compat/linux/usr/lib/libsqlite3.so.0:${PORTSDIR}/databases/linux-f20-sqlite3 \
					/compat/linux/usr/lib/libssl.so.10:${PORTSDIR}/security/linux-f20-openssl-libs \
					/compat/linux/usr/lib/libmng.so.1:${PORTSDIR}/graphics/linux-f20-libmng \
					/compat/linux/usr/lib/libGL.so.1:${PORTSDIR}/graphics/linux-f20-mesa-libGL

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
