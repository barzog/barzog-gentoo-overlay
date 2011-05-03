# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

DESCRIPTION="VerliHub is a Direct Connect protocol server (Hub)"
HOMEPAGE="http://www.verlihub-project.org"
EGIT_PROJECT="verlihub"
EGIT_REPO_URI="git://verlihub.git.sourceforge.net/gitroot/verlihub/verlihub"

inherit git

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~amd64-fbsd ~x86 ~x86-fbsd"

DEPEND="dev-libs/libpcre
	dev-libs/geoip
	>=dev-db/mysql-5.0
	sys-libs/zlib"

src_compile() {
	./configure --prefix=/usr || die "Config failed; please report problems or bugs to http://forums.verlihub-project.org/viewforum.php?f=36"
	emake || die "Make failed; please report problems or bugs to http://forums.verlihub-project.org/viewforum.php?f=36"
}

src_install() {
	make DESTDIR="${D}" install || die
	docinto ""
	dodoc \
		AUTHORS \
		COPYING \
		ChangeLog \
		INSTALL \
		TODO
	dodir /etc/verlihub /etc/verlihub/plugins
	keepdir /etc/verlihub
	insinto /etc/verlihub
	doins share/config/*
	doins "${FILESDIR}/dbconfig"
	newinitd "${FILESDIR}/verlihub.initd" verlihub
	newconfd "${FILESDIR}/verlihub.confd" verlihub
	dosym ../usr/lib/libreplacer_pi.so /etc/verlihub/plugins/
	dosym ../usr/lib/libforbid_pi.so /etc/verlihub/plugins/
	dosym ../usr/lib/libfloodprot_pi.so /etc/verlihub/plugins/
	dosym ../usr/lib/libplug_pi.so /etc/verlihub/plugins/
	dosym ../usr/lib/liblua_pi.so /etc/verlihub/plugins/
	dosym ../usr/lib/libiplog_pi.so /etc/verlihub/plugins/
	dosym ../usr/lib/libchatroom_pi.so /etc/verlihub/plugins/
	dosym ../usr/lib/libstats_pi.so /etc/verlihub/plugins/
	dosym ../usr/lib/libpython_pi.so /etc/verlihub/plugins/
	dosym ../usr/lib/libmessenger_pi.so /etc/verlihub/plugins/
	dosym ../usr/lib/libisp_pi.so /etc/verlihub/plugins/
}

pkg_posinst() {
        einfo   "NOTE: Please note: this software is under development, not completely
                finished, the installation is not user friendly. You would need to
                know how to create and edit files, create a mysql database."
}