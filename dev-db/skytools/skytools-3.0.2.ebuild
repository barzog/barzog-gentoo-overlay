# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="3"

inherit eutils autotools python

DESCRIPTION="Database management tools from Skype: WAL shipping, queueing,replication."
HOMEPAGE="http://pgfoundry.org/projects/skytools/"
SRC_URI="http://pgfoundry.org/frs/download.php/3275/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~x86 ~sparc ~amd64"
IUSE="asciidoc"

PYTHON_DEPEND="2"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="3.* *-jython"
python_enable_pyc

DEPEND=">=dev-db/postgresql-server-8.2
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
	dodoc README NEWS
	cd ${S}/doc
	dodoc overview.txt
	dodir /etc/skytools /var/log/skytools
	newinitd "${FILESDIR}/pgqadm.initd" pgqadm
	newinitd "${FILESDIR}/londiste.initd" londiste
	newconfd "${FILESDIR}/pgqadm.confd" pgqadm
	newconfd "${FILESDIR}/londiste.confd" londiste
}

