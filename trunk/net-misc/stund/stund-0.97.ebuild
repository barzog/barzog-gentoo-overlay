# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

DESCRIPTION="A libipulog-based fork of fprobe - a tool to collect network traffic data and emit it as NetFlow flows"
HOMEPAGE="http://stun.sourceforge.net"
LICENSE="GPL-2"

SRC_URI="mirror://sourceforge/stun/${P}.tgz"
SLOT="0"
KEYWORDS="~x86 ~amd64 ~ppc ~ia64"

IUSE="debug messages"

src_compile() {
	local myconf
	myconf="`use_enable debug`
		`use_enable messages`"
	S="${WORKDIR}/stund"
	cd ${S}
	emake || die "make failed"
}

src_install() {
	cd ${S}
	mv server stun-server
	mv client stun-client
	dosbin stun-server
	dobin stun-client
}
