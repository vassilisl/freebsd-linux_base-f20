# Created by: vassilisl
# $FreeBSD$

PORTNAME=	librtmp
PORTVERSION=	1
CATEGORIES=	net linux
MASTER_SITES=	http://195.220.108.108/linux/rpmfusion/free/fedora/releases/${LINUX_RPM_VERSION}/Everything/${LINUX_CPU_ARCH}/os/
PKGNAMEPREFIX=	linux-f20-
DISTFILES=	${BIN_DISTFILES}
EXTRACT_ONLY=		${DISTFILES} ${DISTFILES_DEPS}

MAINTAINER=	vassilis@einval.com
COMMENT=	RPM for a support library for RTMP streams (Linux Fedora 20)

BIN_DISTFILES=	\
			librtmp-2.4-0.3.20110811gitc58cfb3e.fc19.i686.rpm

ONLY_FOR_ARCHS=	i386 amd64
LINUX_CPU_ARCH=		i386
LINUX_RPM_ARCH=		i686
LINUX_RPM_VERSION=	20
USE_LINUX_PREFIX=	yes
NO_WRKSUBDIR=		yes
DISTINFO_FILE?=		${MASTERDIR}/distinfo.${LINUX_RPM_ARCH}
RUN_DEPENDS=		/compat/linux/usr/lib/libgcrypt.so.11:${PORTSDIRPORTSDIR}/security/linux-f20-libgcrypt \
					/compat/linux/usr/lib/libgnutls.so.28:${PORTSDIR}/security/linux-f20-gnutls

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
