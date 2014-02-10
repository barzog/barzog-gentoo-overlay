# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/flow-tools/flow-tools-0.68.5-r1.ebuild,v 1.1 2010/03/02 16:47:12 jer Exp $

EAPI="2"

inherit eutils user

DESCRIPTION="LLDP/CDP daemon for *NIX"
HOMEPAGE="https://code.google.com/p/ladvd/"
SRC_URI="http://${PN}.googlecode.com/files/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~ia64 ~ppc ~x86"

RDEPEND="dev-libs/libevent"

DEPEND="${RDEPEND}"

pkg_setup() {
        enewgroup ladvd
        enewuser ladvd -1 -1 /var/lib/flows ladvd
}

src_install() {
	emake DESTDIR="${D}" install
	keepdir /var/run/ladvd
	newinitd "${FILESDIR}/ladvd.initd" ladvd
	newconfd "${FILESDIR}/ladvd.confd" ladvd
}