# $FreeBSD: head/Mk/Uses/ada.mk 348308 2014-03-15 10:31:54Z gerald $
#
# Establish Ada-capable compiler as a build dependency
#
# Feature:      ada
# Usage:        USES=ada
# Valid ARGS:   47
#
# MAINTAINER: marino@FreeBSD.org

.if !defined(_INCLUDE_USES_ADA_MK)
_INCLUDE_USES_ADA_MK=    yes

CC= ada

. if defined(ada_ARGS) && ${ada_ARGS} == 47
BUILD_DEPENDS+=	${LOCALBASE}/gcc47-aux/bin/ada:${PORTSDIR}/lang/gcc47-aux
MAKE_ENV+=	PATH=${LOCALBASE}/gcc47-aux/bin:${PATH}
CONFIGURE_ENV+=	PATH=${LOCALBASE}/gcc47-aux/bin:${PATH}
. else
BUILD_DEPENDS+=	${LOCALBASE}/gcc-aux/bin/ada:${PORTSDIR}/lang/gcc-aux
MAKE_ENV+=	PATH=${LOCALBASE}/gcc-aux/bin:${PATH}
CONFIGURE_ENV+=	PATH=${LOCALBASE}/gcc-aux/bin:${PATH}
. endif

MAKE_ENV+=	ADA_PROJECT_PATH=${LOCALBASE}/lib/gnat
CONFIGURE_ENV+=	ADA_PROJECT_PATH=${LOCALBASE}/lib/gnat

.endif
