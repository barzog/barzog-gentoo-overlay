# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/libmemcached/libmemcached-0.50.ebuild,v 1.1 2011/09/04 04:00:39 robbat2 Exp $

EAPI="3"

inherit eutils autotools

DESCRIPTION="An implementation of the IPFIX Protocol as a C library, for building IPFIX Collecting and Exporting Processes."
HOMEPAGE="http://tools.netsa.cert.org/fixbuf/index.html"
SRC_URI="http://tools.netsa.cert.org/releases/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~ppc ~ppc64 ~sh ~sparc ~x86 ~sparc-fbsd ~amd64-linux ~x86-linux ~ppc-macos ~x86-macos"

src_prepare() {
	eautoreconf
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
}
