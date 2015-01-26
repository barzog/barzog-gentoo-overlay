# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/flow-tools/flow-tools-0.68.5-r1.ebuild,v 1.1 2010/03/02 16:47:12 jer Exp $

EAPI="2"

inherit eutils user git-2 autotools

DESCRIPTION="LLDP/CDP daemon for *NIX"
HOMEPAGE="https://github.com/sspans/ladvd"
SRC_URI=""
EGIT_REPO_URI="https://github.com/sspans/ladvd.git"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~ia64 ~ppc ~x86"

RDEPEND="dev-libs/libevent"

DEPEND="${RDEPEND}"

src_unpack() {
    git-2_src_unpack
    cd ${S}
    cat configure.ac | sed -e "s/AC_CC_D_FORTIFY_SOURCE//" > new_conf.ac
    mv new_conf.ac configure.ac
    eautoreconf
}

pkg_setup() {
        enewgroup ladvd
        enewuser ladvd -1 -1 /var/lib/flows ladvd
}

src_install() {
	emake DESTDIR="${D}" install
	newinitd "${FILESDIR}/ladvd.initd" ladvd
	newconfd "${FILESDIR}/ladvd.confd" ladvd
}