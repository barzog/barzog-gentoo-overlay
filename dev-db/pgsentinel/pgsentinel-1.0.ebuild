# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5
inherit git-2
POSTGRES_COMPAT=( 10 11 )


DESCRIPTION="Pgsentinel – sampling active session history"
HOMEPAGE="https://www.pgsentinel.com/"
EGIT_REPO_URI="https://github.com/pgsentinel/pgsentinel.git"

LICENSE="POSTGRESQL"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

DEPEND=" || (
                dev-db/postgresql:10[server]
                dev-db/postgresql:11[server]
        )"

RDEPEND="${DEPEND}"
src_install() {
		cd src/
		emake DESTDIR="${D}" install
}