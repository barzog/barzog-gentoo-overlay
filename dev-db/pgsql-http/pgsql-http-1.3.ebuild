# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="4"

inherit eutils autotools git-2

DESCRIPTION="HTTP client for PostgreSQL, retrieve a web page from inside the database."
HOMEPAGE="https://github.com/pramsey/pgsql-http"
EGIT_REPO_URI="https://github.com/pramsey/pgsql-http.git"
LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND="|| (
                dev-db/postgresql:9.6[server]
                dev-db/postgresql:9.5[server]
                dev-db/postgresql:9.4[server]
                dev-db/postgresql:9.3[server]
        )"

RDEPEND="${DEPEND}"

src_compile() {
    emake USE_PGXS=1
}

src_install() {
    emake DESTDIR="${D}" USE_PGXS=1 install
}