# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit eutils autotools python

DESCRIPTION="Database management tools from Skype: WAL shipping, queueing,replication."
HOMEPAGE="http://pgfoundry.org/projects/skytools/"
SRC_URI="http://pgfoundry.org/frs/download.php/2872/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~x86 ~sparc ~amd64"
IUSE="asciidoc"

DEPEND=">=dev-db/postgresql-server-8.2
		asciidoc? ( app-text/asciidoc )
		dev-python/psycopg"
RDEPEND="${DEPENDS}"

src_unpack(){
	unpack ${A}
	cd ${S}
	eautoreconf
}

src_compile(){
	econf \
		$(use_with asciidoc) || die
	emake || die
}

src_install(){
	emake DESTDIR="${D}" install || die
	dodoc README NEWS
	cd ${S}/doc
	dodoc overview.txt
	dodir /etc/skytools /var/log/skytools
	doinitd ${FILESDIR}/${PV}/init.d/pgqadm ${FILESDIR}/${PV}/init.d/londiste
	doconfd ${FILESDIR}/${PV}/conf.d/pgqadm ${FILESDIR}/${PV}/conf.d/londiste
}

pkg_postinst(){
	python_mod_optimize
	einfo "See overview.txt for links for How-To's"
}

pkg_postrm(){
	python_mod_cleanup
}