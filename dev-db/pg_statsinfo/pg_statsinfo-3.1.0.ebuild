# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=3

inherit eutils autotools 

DESCRIPTION="utility that monitor statistics and the activity of PostgreSQL(and OS)"
HOMEPAGE="http://pgstatsinfo.projects.pgfoundry.org/"
SRC_URI="http://sourceforge.net/projects/pgstatsinfo/files/pg_statsinfo/3.1.0/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~x86 ~amd64"


DEPEND="<=dev-db/postgresql-9.4[xml,static-libs,server]
	dev-db/repmgr"
RDEPEND="${DEPENDS}"

#src_configure() {
#	cd ${S}/agent/bin
#	sed -i '34 i LIBS := $(filter -lpgport -lpgcommon, $(LIBS))' Makefile
#}

src_compile() {
	emake USE_PGXS=1
}

src_install() {
	emake DESTDIR="${D}" install || die
}
