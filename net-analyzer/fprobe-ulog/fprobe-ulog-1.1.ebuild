# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

DESCRIPTION="A libipulog-based fork of fprobe - a tool to collect network traffic data and emit it as NetFlow flows"
HOMEPAGE="http://fprobe.sourceforge.net"
LICENSE="GPL-2"

SRC_URI="mirror://sourceforge/fprobe/${P}.tar.bz2"
SLOT="0"
KEYWORDS="~x86 ~amd64 ~ppc ~ia64"

IUSE="debug messages"

src_compile() {
	local myconf
	myconf="`use_enable debug`
		`use_enable messages`"

	econf ${myconf} || die "configure failed"

	emake || die "make failed"
}

src_install() {
	make DESTDIR="${D}" install || die "install failed"

	dodoc AUTHORS NEWS README TODO
	docinto contrib ; dodoc contrib/tg.sh
	
	newinitd "${FILESDIR}/fprobe-ulog.initd" fprobe-ulog
	newconfd "${FILESDIR}/fprobe-ulog.confd" fprobe-ulog
}
