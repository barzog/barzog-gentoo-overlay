# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-p2p/transmission/transmission-2.41.ebuild,v 1.2 2011/10/19 11:49:53 pva Exp $

EAPI=4
inherit eutils autotools
TINYXML_PN=tinyxml
TINYXML_PV=2.6.2
DESCRIPTION="PtokaX Direct Connect Hub is a multi-platform server application for Neo-Modus Direct Connect Peer-To-Peer sharing network."
HOMEPAGE="http://www.ptokax.org"
SRC_URI="http://www.czdc.org/PtokaX/${PV}-nix-src.tgz
	 mirror://sourceforge/${TINYXML_PN}/${TINYXML_PN}_${TINYXML_PV//./_}.tar.gz" 

LICENSE="MIT GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND="dev-libs/tinyxml
	dev-lang/lua"
DEPEND="${RDEPEND}"

S="${WORKDIR}/${PN}"

src_unpack() {
	unpack ${A}
	rm ${WORKDIR}/tinyxml/Makefile
	cp ${S}/tinyxml/makefile ${WORKDIR}/tinyxml/makefile
	rm -rf ${S}/tinyxml
	ln -s ${WORKDIR}/tinyxml ${S}/tinyxml
	mkdir ${S}/tinyxml/obj
}

src_prepare() {
	sed -i 's/-llua5.1/-llua/' "${S}/makefile"
}

src_compile() {
	cd ${S}/tinyxml
	emake
	cd ${S}
	emake
}

src_install() {
	dobin PtokaX
	insinto /etc/PtokaX/cfg
	doins -r ${S}/cfg.example/*
	insinto /etc/PtokaX/language
	doins -r ${S}/language/*
	newinitd "${FILESDIR}/PtokaX.initd" PtokaX
	mkdir /etc/PtokaX/scripts
	mkdir /etc/PtokaX/texts
	mkdir /var/log/PtokaX
	ln -S /var/log/PtokaX /etc/PtokaX/logs
}

pkg_postinst() {
	enewgroup ptokax
	enewuser ptokax -1 -1 /dev/nul ptokax
}