# Created by: vassilisl
# $FreeBSD$

PORTNAME=	libxml2
PORTVERSION=	1
CATEGORIES=		devel linux
MASTER_SITES=		http://archives.fedoraproject.org/pub/fedora/linux/releases/${LINUX_RPM_VERSION}/Everything/${LINUX_CPU_ARCH}/os/Packages/
PKGNAMEPREFIX=	linux-f20-
DISTFILES=	${BIN_DISTFILES}
EXTRACT_ONLY=		${DISTFILES} ${DISTFILES_DEPS}

MAINTAINER=		vassilis@einval.com
COMMENT=	Library providing XML and HTML support (Linux Fedora 20)

BIN_DISTFILES=	\
			l/libxml2-2.9.1-2.fc${LINUX_RPM_VERSION}.${LINUX_RPM_ARCH}.rpm

ONLY_FOR_ARCHS=	i386 amd64
LINUX_CPU_ARCH=		i386
LINUX_RPM_ARCH=		i686
LINUX_RPM_VERSION=	20
USE_LINUX_PREFIX=	yes
NO_WRKSUBDIR=		yes
DISTINFO_FILE?=		${MASTERDIR}/distinfo.${LINUX_RPM_ARCH}
RUN_DEPENDS=		/compat/linux/usr/lib/liblzma.so.5:${PORTSDIR}/archivers/linux-f20-xz-libs

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
