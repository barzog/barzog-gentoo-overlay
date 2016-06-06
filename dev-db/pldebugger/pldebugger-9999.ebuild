# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="4"

inherit eutils autotools git-2

DESCRIPTION="PostgreSQL pl/pgsql Debugger API"
HOMEPAGE="https://git.postgresql.org/gitweb/?p=pldebugger.git;a=summary"
EGIT_REPO_URI="git://git.postgresql.org/git/pldebugger.git"
#SRC_URI="mirror://postgresql/source/v9.5.3/postgresql-9.5.3.tar.bz2"
LICENSE="BSD"
SLOT="0"
KEYWORDS="~x86 ~sparc ~amd64"
IUSE=""

DEPEND=" || ( 
                dev-db/postgresql:9.5[server,perl]
                dev-db/postgresql:9.4[server,perl]
                dev-db/postgresql:9.3[server,perl]
                dev-db/postgresql:9.2[server,perl]
                dev-db/postgresql:9.1[server,perl]
                dev-db/postgresql:9.0[server,perl]
            )"
              
src_compile() {
    emake USE_PGXS=1
}

src_install() {
    emake DESTDIR="${D}" USE_PGXS=1 install
}
