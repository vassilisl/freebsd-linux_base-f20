# $FreeBSD: head/Mk/Uses/readline.mk 363125 2014-07-28 10:22:54Z bapt $
#
# handle dependency on the readline port
#
# Feature:	readline
# Usage:	USES=readline
# Valid ARGS:	port
#
# MAINTAINER: portmgr@FreeBSD.org

.if !defined(_INCLUDE_USES_READLINE_MK)
_INCLUDE_USES_READLINE_MK=	yes

.if !exists(/usr/lib/libreadline.so)
readline_ARGS=	port
.endif

.if defined(readline_ARGS) && ${readline_ARGS} == port
LIB_DEPENDS+=		libreadline.so.6:${PORTSDIR}/devel/readline
CPPFLAGS+=		-I${LOCALBASE}/include
LDFLAGS+=		-L${LOCALBASE}/lib
.endif

.endif
