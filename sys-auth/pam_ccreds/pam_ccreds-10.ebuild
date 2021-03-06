# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header$

inherit pam autotools eutils

DESCRIPTION="PAM module that provides disconnected authentication"
HOMEPAGE="http://www.padl.com/OSS/pam_ccreds.html"
SRC_URI="http://www.padl.com/download/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="sys-libs/pam
	=sys-libs/db-4.8*"
RDEPEND="${DEPEND}"

src_unpack() {
	unpack ${A}
	cd "${S}"
	mv configure.in configure.ac
	eautoreconf
}

src_compile() {
	econf --prefix=/ || die "econf failed"
	emake -j1 || die "emake failed"
}

src_install() {
	dopammod pam_ccreds.so
	dosbin cc_{dump,test} ccreds_chkpwd
	dodoc AUTHORS ChangeLog NEWS README pam.conf
}
