# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: 
EAPI=4

DESCRIPTION="Mapnik World Boundaries"
HOMEPAGE="http://wiki.openstreetmap.org/wiki/Mapnik#World%20boundaries"
SRC_URI="http://tile.openstreetmap.org/world_boundaries-spherical.tgz
	http://tile.openstreetmap.org/processed_p.tar.bz2
	http://tile.openstreetmap.org/shoreline_300.tar.bz2
	http://www.naturalearthdata.com/http//www.naturalearthdata.com/download/10m/cultural/ne_10m_populated_places.zip
	http://www.naturalearthdata.com/http//www.naturalearthdata.com/download/110m/cultural/ne_110m_admin_0_boundary_lines_land.zip
"

LICENSE="dbcl-10 public-domain"
SLOT="0"

KEYWORDS="~amd64 ~ppc ~x86"

IUSE=""

DEPEND="app-arch/bzip2
	app-arch/unzip
"
RDEPEND=""

S="${WORKDIR}"

src_prepare() {
	mv ne_110m_admin* ne_10m_populated* processed_p* shoreline* world_boundaries/
}

src_install() {
	insinto /usr/lib/mapnik
	doins -r world_boundaries
	dosym /usr/lib/mapnik/world_boundaries/ne_110m_admin_0_boundary_lines_land.shp /usr/lib/mapnik/world_boundaries/110m_admin_0_boundary_lines_land.shp
	dosym /usr/lib/mapnik/world_boundaries/ne_110m_admin_0_boundary_lines_land.dbf /usr/lib/mapnik/world_boundaries/110m_admin_0_boundary_lines_land.dbf
}
