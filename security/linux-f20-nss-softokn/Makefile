# Created by: vassilisl
# $FreeBSD$

PORTNAME=	nss-softokn
PORTVERSION=	1
CATEGORIES=		security linux
MASTER_SITES=		http://archives.fedoraproject.org/pub/fedora/linux/releases/${LINUX_RPM_VERSION}/Everything/${LINUX_CPU_ARCH}/os/Packages/
PKGNAMEPREFIX=	linux-f20-
DISTFILES=	${BIN_DISTFILES}
EXTRACT_ONLY=		${DISTFILES} ${DISTFILES_DEPS}

MAINTAINER=		vassilis@einval.com
COMMENT=		Network Security Services Softoken Module (Linux Fedora 20)

BIN_DISTFILES=	\
			n/nss-softokn-3.15.2-2.fc${LINUX_RPM_VERSION}.${LINUX_RPM_ARCH}.rpm

ONLY_FOR_ARCHS=	i386 amd64
LINUX_CPU_ARCH=		i386
LINUX_RPM_ARCH=		i686
LINUX_RPM_VERSION=	20
USE_LINUX_PREFIX=	yes
NO_WRKSUBDIR=		yes
DISTINFO_FILE?=		${MASTERDIR}/distinfo.${LINUX_RPM_ARCH}
RUN_DEPENDS=		/compat/linux/lib/libc.so.6:${PORTSDIR}/emulators/linux_base-f20 \
					/compat/linux/lib/usr/lib/libnspr4.so:${PORTSDIR}/devel/linux-f20-nspr4 \
					/compat/linux/usr/lib/libnssutil3.so:${PORTSDIR}/security/linux-f20-nss-util \
					/compat/linux/usr/lib/libsqlite3.so.0:${PORTSDIR}databases/linux-f20-sqlite3

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
