# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/flow-tools/flow-tools-0.68.5-r1.ebuild,v 1.1 2010/03/02 16:47:12 jer Exp $

EAPI="2"

inherit eutils user autotools flag-o-matic

DESCRIPTION="LLDP/CDP daemon for *NIX"
HOMEPAGE="https://github.com/sspans/ladvd/releases"
SRC_URI="http://github.com/sspans/${PN}/archive/v${PV}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 x86"

RDEPEND="dev-libs/libevent"

DEPEND="${RDEPEND}"

pkg_setup() {
        enewgroup ladvd
        enewuser ladvd -1 -1 /var/lib/flows ladvd
}

src_prepare() {
    cd ${S}
    sed -i '/AC_CC_D_FORTIFY_SOURCE/d' configure.ac
    eautoreconf
}

src_configure() {
    append-flags "-D_DEFAULT_SOURCE"
    econf
}

src_install() {
	emake DESTDIR="${D}" install
	newinitd "${FILESDIR}/ladvd.initd" ladvd
	newconfd "${FILESDIR}/ladvd.confd" ladvd
}