# $FreeBSD: head/Mk/Uses/tk.mk 348308 2014-03-15 10:31:54Z gerald $
#
# vim: ts=8 noexpandtab
#

.if defined(tk_ARGS)
tcl_ARGS:=	${tk_ARGS}
.endif

_TCLTK_PORT=	tk

.include "${PORTSDIR}/Mk/Uses/tcl.mk"
