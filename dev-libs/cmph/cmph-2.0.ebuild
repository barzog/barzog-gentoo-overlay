# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

DESCRIPTION="Library for building large minimal perfect hashes"
HOMEPAGE="http://cmph.sf.net/"
SRC_URI="mirror://sourceforge/cmph/${PN}/${P}.tar.gz"
LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""
DEPEND="sys-devel/gcc"
RDEPEND="${DEPEND}"

#S=${WORKDIR}/${P}

src_compile() {
	econf || die "econf failed"
	emake || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" install || die
}
