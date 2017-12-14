# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=3

inherit eutils autotools 

DESCRIPTION="PL/Proxy is database partitioning system implemented as PL language."
HOMEPAGE="https://plproxy.github.io/"
SRC_URI="https://plproxy.github.io/downloads/files/${PV}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~x86 ~amd64"


DEPEND="dev-db/postgresql[server]"
RDEPEND="${DEPENDS}"

src_install() {
	emake DESTDIR="${D}" install || die
}