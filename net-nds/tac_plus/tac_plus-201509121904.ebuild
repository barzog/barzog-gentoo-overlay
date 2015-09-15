# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

inherit autotools base libtool

MY_P="PROJECTS"
S="${WORKDIR}/${MY_P}"

DESCRIPTION="An updated version of Cisco's TACACS+ server"
HOMEPAGE="http://www.shrubbery.net/tac_plus/"
SRC_URI="http://www.pro-bono-publico.de/projects/src/DEVEL.${PV}.tar.bz2"

LICENSE="HPND RSA GPL-2" # GPL-2 only for init script
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"

src_prepare() {
	sed -i -e "s:/usr/local/lib:${EPREFIX}/usr/lib:g" mavis/perl/mavis_*.pl || die
	# Fix manpage.
        sed -i -e "s:/usr/local/etc:${EPREFIX}/etc:g" doc/*.txt || die
	sed -i -e "s:/usr/local:${EPREFIX}/usr:g" doc/*.txt || die
        sed -i -e "s:/usr/local/etc:${EPREFIX}/etc:g" doc/*.html || die
	sed -i -e "s:/usr/local:${EPREFIX}/usr:g" doc/*.html || die
}

src_configure() {
	./configure \
	--prefix=/usr \
	--etcdir=/etc \
	--installroot="${D}" \
	mavis tac_plus \
	|| die "econf failed"
}

src_compile() {
	CFLAGS="-Wall -W -Wno-strict-prototypes"
	make -j1 || die "compile failed"
}
src_install() {
	make install || die "install failed"
        newinitd "${FILESDIR}/tac_plus.initd" tac_plus
        newconfd "${FILESDIR}/tac_plus.confd" tac_plus
	insinto /etc
	doins "tac_plus/sample/tac_plus.cfg"
}
