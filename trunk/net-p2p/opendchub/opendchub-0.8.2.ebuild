# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="3"

inherit autotools

DESCRIPTION="hub software for Direct Connect"
HOMEPAGE="http://opendchub.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="perl"

RDEPEND="perl? ( dev-lang/perl )"
DEPEND="${RDEPEND}"

src_prepare() {
	eautomake || die "eautomake failed"
}

src_configure() {
	! use perl && myconf="--disable-perl --enable-switch_user"
	econf $myconf || die "configure failed"
}

src_install() {
	einstall || die "install failed"
	if use perl ; then
		exeinto "${EPREFIX}/usr/bin"
		doexe "${FILESDIR}/opendchub_setup.sh"
		dodir "${EPREFIX}/usr/share/opendchub/scripts"
		insinto "${EPREFIX}/usr/share/opendchub/scripts"
		doins Samplescripts/*
	fi
	dodoc Documentation/*
	newinitd "${FILESDIR}/opendchub.initd" opendchub
}

pkg_postinst() {
	if use perl ; then
		einfo "To set up perl scripts for opendchub to use, please run"
		einfo "opendchub_setup.sh as the user you will be using opendchub as."
	fi
}
