# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header:

EAPI=4

inherit eutils apache-module autotools git-2

EGIT_REPO_URI="https://github.com/openstreetmap/mod_tile"

DESCRIPTION="Apache module to efficiently render and serve tiles for openstreetmap using mapnik"
HOMEPAGE="http://wiki.openstreetmap.org/wiki/Mod_tile"
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

APACHE2_MOD_CONF="14_${PN}"
APACHE2_MOD_DEFINE="MOD_TILE"

need_apache2

src_prepare() {
	eautoreconf
}

src_configure() {
	econf --with-apxs=${APXS}
}

src_compile() {
	make || die "make failed"
}

src_install() {
	make DESTDIR="${D}" install || die "make install failed"
	dodoc readme.txt
	doman docs/*.1
	insinto /var/www/osm
	newins slippymap.html index.html
	newinitd "${FILESDIR}"/renderd.rc renderd
	dodir /var/lib/mod_tile
	apache-module_src_install
}
