# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header:

EAPI=4

inherit subversion

ESVN_REPO_URI="http://svn.openstreetmap.org/applications/rendering/mapnik"
ESVN_PROJECT="${PN}"

DESCRIPTION="Additional tools required to configure mapnik"
HOMEPAGE="http://wiki.openstreetmap.org/wiki/Mapnik"
SRC_URI=""

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64 ~ppc ~ppc64"
IUSE=""

DEPEND="
	app-arch/bzip2
	media-libs/freetype
	sci-geosciences/mapnik
	sys-libs/zlib
"
RDEPEND="${DEPEND}"

src_prepare() {
	esvn_clean
}

src_install() {
	exeinto /usr/lib/mapnik
	doexe *.py *.sh *.pl
	insinto /usr/lib/mapnik
	doins *.txt osm.xml README
	doins -r inc/ symbols/ utils/
}
