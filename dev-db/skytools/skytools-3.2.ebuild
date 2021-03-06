# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5
PYTHON_COMPAT=( python{2_6,2_7,3_2,3_3} )

inherit eutils autotools python-r1

DESCRIPTION="Database management tools from Skype: WAL shipping, queueing,replication."
HOMEPAGE="http://pgfoundry.org/projects/skytools/"
SRC_URI="http://pgfoundry.org/frs/download.php/3622/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~x86 ~sparc ~amd64"
IUSE="asciidoc"

DEPEND=">=dev-db/postgresql-8.2[server]
		asciidoc? ( app-text/asciidoc )
		dev-python/psycopg"
RDEPEND="${DEPENDS}"
AT_M4DIR="${S}/lib/m4"

src_unpack(){
	unpack ${A}
	cd ${S}
	eautoreconf
}

src_configure() {
        econf \
                $(use_with asciidoc) || die

}

src_compile(){
        emake || die
}

src_install(){
	emake DESTDIR="${D}" install || die
	dodir /etc/skytools /var/log/skytools
	newinitd "${FILESDIR}/pgqadm.initd" pgqadm
	newinitd "${FILESDIR}/londiste.initd" londiste
	newconfd "${FILESDIR}/pgqadm.confd" pgqadm
	newconfd "${FILESDIR}/londiste.confd" londiste
}
