# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI="4"

inherit autotools

DESCRIPTION="Linux command line tools for fallocate, fincore, fadvise"
HOMEPAGE="https://code.google.com/p/linux-ftools/"
SRC_URI="http://www.hartwork.org/public/${P}.tar.xz"

LICENSE="GPL-2+"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DOCS=( README )

src_prepare() {
	# Re-generate out of sync files:
	rm configure Makefile.in || die
	eautoreconf
}
