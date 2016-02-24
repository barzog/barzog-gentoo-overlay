# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header:

EAPI=4

inherit git-2

EGIT_REPO_URI="https://github.com/openstreetmap/openstreetmap-website.git"

DESCRIPTION="The Rails port is the current production version of OSM's server code - API, web front end and everything that runs on www.openstreetmap.org"
HOMEPAGE="http://wiki.openstreetmap.org/wiki/The_Rails_Port"
SRC_URI=""

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="
	dev-lang/ruby
"
RDEPEND="${DEPEND}"


src_install() {
        insinto /opt/osm/openstreetmap-website
        doins -r *
}
