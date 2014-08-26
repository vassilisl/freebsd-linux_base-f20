# Created by: vassilisl
# $FreeBSD$

PORTNAME=	cups-libs
PORTVERSION=	1
CATEGORIES=	print linux
MASTER_SITES=		http://archives.fedoraproject.org/pub/fedora/linux/releases/${LINUX_RPM_VERSION}/Everything/${LINUX_CPU_ARCH}/os/Packages/
PKGNAMEPREFIX=	linux-f20-
DISTFILES=	${BIN_DISTFILES}

MAINTAINER=	vassilis@einval.com
COMMENT=	CUPS printing system - libraries (Linux Fedora 20)

BIN_DISTFILES=	\
			c/cups-libs-1.7.0-4.fc${LINUX_RPM_VERSION}.${LINUX_RPM_ARCH}.rpm

ONLY_FOR_ARCHS=	i386 amd64
LINUX_CPU_ARCH=		i386
LINUX_RPM_ARCH=		i686
LINUX_RPM_VERSION=	20
USE_LINUX_PREFIX=	yes
NO_WRKSUBDIR=		yes
DISTINFO_FILE?=		${MASTERDIR}/distinfo.${LINUX_RPM_ARCH}
RUN_DEPENDS=		/compat/linux/lib/libc.so.6:${PORTSDIR}/emulators/linux_base-f20 \
					/compat/linux/lib/libaudit.so.1:${PORTSDIR}/security/linux-f20-audit-libs \
					/compat/linux/usr/lib/libavahi-client.so.3:${PORTSDIR}/net/linux-f20-avahi-libs \
					/compat/linux/usr/lib/libssl.so.10:${PORTSDIR}/security/linux-f20-openssl-libs

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
