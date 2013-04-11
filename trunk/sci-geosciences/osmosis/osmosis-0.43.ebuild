# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header:

EAPI=4

DESCRIPTION="Commandline tool to process openstreetmap data"
HOMEPAGE="http://wiki.openstreetmap.org/index.php/Osmosis"
SRC_URI="http://bretth.dev.openstreetmap.org/osmosis-build/${P}-RELEASE.tgz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="mysql postgres"

DEPEND="
	mysql? ( >=dev-java/jdbc-mysql-5 )
	postgres? ( >=dev-java/jdbc-postgresql-8.2 )
	>=virtual/jdk-1.5"

S="${WORKDIR}"

pkg_setup() {
	if ! use mysql && ! use postgres; then
		ewarn "If you use neither the mysql nor the postgres USE-flags"
		ewarn "you will have no support for databases"
	fi
}

src_install() {
        insinto /opt/osm/osmosis
	doins -r config
	doins -r lib
	doins -r script
	doins changes.txt
	doins copying.txt
	doins readme.txt
	exeinto /opt/osm/osmosis/bin
	doexe bin/*
}
