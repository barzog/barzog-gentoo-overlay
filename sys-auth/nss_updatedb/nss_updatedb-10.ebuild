# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header$

DESCRIPTION="Utility that maintains a local cache of network directory user and group information"
HOMEPAGE="http://www.padl.com/OSS/nss_updatedb.html"
SRC_URI="http://www.padl.com/download/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="sys-libs/db"
RDEPEND="${DEPEND}"

src_install() {
	emake install DESTDIR="${D}" || die "emake install failed"

	dodoc AUTHORS ChangeLog README
}
