# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $
EAPI=4

inherit eutils subversion autotools

DESCRIPTION="Asterisk Huawei 3G Dongle Channel Driver."
ESVN_REPO_URI="http://asterisk-chan-dongle.googlecode.com/svn/trunk/"
HOMEPAGE="http://code.google.com/p/asterisk-chan-dongle/"
KEYWORDS=""

LICENSE="GPL-3"
SLOT="0"
IUSE=""

RDEPEND=">=net-misc/asterisk-1.6.2.0"
DEPEND="${RDEPEND}"

WANT_AUTOMAKE="1.11.1"

src_prepare() {
	cd ${S}
	touch Makefile.am
#	eaclocal
#	eautoconf
	eautomake	
}

src_install() {
	insinto /usr/$(get_libdir)/asterisk/modules
	doins "${PN/*-/}.so"
	insinto /etc/asterisk
	doins etc/datacard.conf
	newdoc README.txt README
	newdoc LICENSE.txt LICENSE
}
