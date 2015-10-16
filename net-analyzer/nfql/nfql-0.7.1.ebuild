# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/libmemcached/libmemcached-0.50.ebuild,v 1.1 2011/09/04 04:00:39 robbat2 Exp $

EAPI="3"

inherit cmake-utils

DESCRIPTION="An efficient C implementation of the network flow query language (NFQL)."
HOMEPAGE="http://nfql.vaibhavbajpai.com/"
SRC_URI="https://github.com/vbajpai/${PN}/releases/download/v${PV}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~ppc ~ppc64 ~sh ~sparc ~x86 ~sparc-fbsd ~amd64-linux ~x86-linux ~ppc-macos ~x86-macos"

DEPEND="dev-libs/json-c
		dev-libs/libfixbuf"
RDEPEND="${DEPEND}"

src_prepare() {
	sed -i 's/json/json-c/g' CMakeLists.txt
	sed -i -e 's:json/:json-c/:' src/f.c
}

