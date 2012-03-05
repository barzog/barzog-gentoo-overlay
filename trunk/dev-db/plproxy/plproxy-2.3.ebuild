# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit eutils autotools 

DESCRIPTION="PL/Proxy is database partitioning system implemented as PL language."
HOMEPAGE="http://pgfoundry.org/projects/plproxy/"
SRC_URI="http://pgfoundry.org/frs/download.php/3160/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~x86 ~amd64"
EAPI="3"

DEPEND=">=dev-db/postgresql-server-8.2"
RDEPEND="${DEPENDS}"

src_install() {
	emake DESTDIR="${D}" install || die
}