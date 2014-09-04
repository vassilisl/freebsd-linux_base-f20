# $FreeBSD: head/Mk/Uses/desktop-file-utils.mk 366839 2014-09-01 05:43:02Z bapt $
#
# handle dependency depends on desktop-file-utils and package regen
#
# Feature:	desktop-file-utils
# Usage:	USES=desktop-file-utils
# Valid ARGS:	does not require args
#
# MAINTAINER: gnome@FreeBSD.org

.if !defined(_INCLUDE_USES_DESKTOP_FILE_UTILS_MK)
_INCLUDE_USES_DESKTOP_FILE_UTILS_MK=	yes

.if defined(desktop-file-utils_ARGS)
IGNORE=	USES=desktop-file-utils does not require args
.endif

BUILD_DEPENDS+=	update-desktop-database:${PORTSDIR}/devel/desktop-file-utils
RUN_DEPENDS+=	update-desktop-database:${PORTSDIR}/devel/desktop-file-utils

desktop-file-post-install:
# plist entries for packages.
	@${ECHO_CMD} "@exec ${LOCALBASE}/bin/update-desktop-database -q > /dev/null || /usr/bin/true" \
		>> ${TMPPLIST}; \
	${ECHO_CMD} "@unexec ${LOCALBASE}/bin/update-desktop-database -q > /dev/null || /usr/bin/true" \
		>> ${TMPPLIST}

.endif
