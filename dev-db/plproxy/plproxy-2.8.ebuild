# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=3

inherit eutils autotools 
POSTGRES_COMPAT=( 9.{3,4,5,6} 10 )

DESCRIPTION="PL/Proxy is database partitioning system implemented as PL language."
HOMEPAGE="https://plproxy.github.io/"
SRC_URI="https://plproxy.github.io/downloads/files/${PV}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~x86 ~amd64"

DEPEND="( 
	dev-db/postgresql:10[server]
	dev-db/postgresql:9.6[server]
	dev-db/postgresql:9.5[server]
	dev-db/postgresql:9.4[server]
	dev-db/postgresql:9.3[server]
)"

RDEPEND="${DEPENDS}"

src_install() {
	emake DESTDIR="${D}" install || die
}