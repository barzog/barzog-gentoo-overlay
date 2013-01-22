# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4
inherit eutils
DESCRIPTION="Forwarding stream between multicast and unicast"
HOMEPAGE="http://www.poempelfox.de/getstream-poempel/"
SRC_URI="http://www.poempelfox.de/getstream-poempel/getstream-poempel-20070210.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

S="${WORKDIR}/getstream-poempel-20070210"

src_compile() {
	cd ${S}
	emake streamforwarder || die
}

src_install() {
	dobin streamforwarder
}
