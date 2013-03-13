# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-db/slony1/slony1-2.1.2.ebuild,v 1.1 2013/01/12 21:37:18 titanofold Exp $

EAPI="4"

inherit eutils versionator

IUSE="doc perl"

DESCRIPTION="A replication system for the PostgreSQL Database Management System"
HOMEPAGE="http://slony.info/"

# ${P}-docs.tar.bz2 contains man pages as well as additional documentation
MAJ_PV=$(get_version_component_range 1-2)
SRC_URI="http://main.slony.info/downloads/${MAJ_PV}/source/${P}.tar.bz2
		 http://main.slony.info/downloads/${MAJ_PV}/source/${P}-docs.tar.bz2"

LICENSE="BSD GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"

DEPEND="|| (
			dev-db/postgresql-server:9.2
			dev-db/postgresql-server:9.1
			dev-db/postgresql-server:9.0
			dev-db/postgresql-server:8.4
			dev-db/postgresql-server:8.3
		)
		dev-db/postgresql-base[threads]
		perl? ( dev-perl/DBD-Pg )
"

pkg_setup() {
	local PGSLOT="$(postgresql-config show)"
	if [[ ${PGSLOT//.} < 83 ]] ; then
		eerror "You must build ${CATEGORY}/${PN} against PostgreSQL 8.3 or higher."
		eerror "Set an appropriate slot with postgresql-config."
		die "postgresql-config not set to 8.3 or higher."
	fi
	enewuser slony1 -1 -1 -1 "postgres"
}

src_prepare() {
	epatch "${FILESDIR}/slony1-2.1.2-ldflags.patch"
}

src_configure() {
	local myconf
	use perl && myconf='--with-perltools'
	econf ${myconf}
}

src_install() {
	emake DESTDIR="${D}" install

	dodoc HISTORY-1.1 INSTALL README SAMPLE TODO UPGRADING doc/howto/*.txt

	doman "${S}"/doc/adminguide/man{1,7}/*

	if use doc ; then
		cd "${S}"/doc
		dohtml -r *
	fi

        newinitd "${FILESDIR}"/slony1.initd slony1
        insinto /etc/slony1
        doins ${FILESDIR}/slony1.conf
        fperms 660 /etc/slony1/slony1.conf
        fowners slony1:postgres /etc/slony1/slony1.conf
}
