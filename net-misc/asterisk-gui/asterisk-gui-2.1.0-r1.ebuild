# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: Author: mva $

EAPI=4

inherit subversion

DESCRIPTION="Asterisk's GUI."
HOMEPAGE="http://www.digium.com/"
ESVN_REPO_URI="http://svn.digium.com/svn/asterisk-gui/tags/2.1.0-rc1"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

RDEPEND=">=net-misc/asterisk-1.8.5.0"
DEPEND="${RDEPEND}"

src_configure() {
	econf --localstatedir=/var
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"

	insinto /etc/asterisk
	newins providers.conf.sample providers.conf

	dodoc README CREDITS requests.txt security.txt other/sqlite.js
	chown -R asterisk:asterisk /var/lib/asterisk/static-http/config
}
