# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-analyzer/flow-tools/flow-tools-0.68-r6.ebuild,v 1.1 2009/05/26 01:26:21 jer Exp $

WANT_AUTOMAKE="1.6"
WANT_AUTOCONF="latest"
inherit eutils flag-o-matic autotools

DESCRIPTION="Flow-tools-ng is a package for collecting and processing NetFlow data"
HOMEPAGE="http://code.google.com/p/flow-tools/"
SRC_URI="http://flow-tools.googlecode.com/files/${P}.tar.bz2"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~ia64 ~ppc ~x86"
IUSE="mysql postgres debug ssl"

RDEPEND="sys-apps/tcp-wrappers
	sys-libs/zlib
	sys-devel/flex
	!postgres? ( mysql? ( virtual/mysql ) )
	!mysql? ( postgres? ( virtual/postgresql-server ) )
	ssl? ( dev-libs/openssl )"

DEPEND="${RDEPEND}
	sys-devel/bison"

pkg_setup() {
	if use mysql && use postgres ; then
		echo
		eerror "The mysql and postgres USE flags are mutually exclusive."
		eerror "Please choose either USE=mysql or USE=postgres, but not both."
		die
	fi

	enewgroup flows
	enewuser flows -1 -1 /var/lib/flows flows
}

src_unpack() {
	unpack ${A}
	cd "${S}"
	epatch "${FILESDIR}"/${P}-patch-src_flow-print.c
}

src_compile() {
	use mysql && append-flags "-L/usr/lib/mysql -I/usr/include/mysql"
	use postgres && append-flags "-L/usr/lib/postgres -I/usr/include/postgres"

	econf \
		--localstatedir=/etc/flow-tools \
		--enable-lfs \
		$(use_with ssl openssl) \
		$(use_with mysql) \
		$(use_with postgres pgsql) \
		|| die "econf failed"

	emake CFLAGS="${CFLAGS}" || die "emake failed"
}

src_install() {
	make DESTDIR="${D}" install || die "make install failed"
	dodoc ChangeLog README SECURITY TODO

	keepdir /var/lib/flows
	keepdir /var/lib/flows/bin
	exeinto /var/lib/flows/bin
	doexe "${FILESDIR}"/linkme
	keepdir /var/run/flows

	newinitd "${FILESDIR}/flowcapture.initd" flowcapture
	newconfd "${FILESDIR}/flowcapture.confd" flowcapture

}

pkg_postinst() {
	chown flows:flows /var/run/flows
	chown flows:flows /var/lib/flows
	chown flows:flows /var/lib/flows/bin
	chmod 0755 /var/run/flows
	chmod 0755 /var/lib/flows
	chmod 0755 /var/lib/flows/bin
}
