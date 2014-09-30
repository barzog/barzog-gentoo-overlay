# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

inherit cmake-utils subversion
DESCRIPTION="XBT BitTorrent tracker"
HOMEPAGE="http://xbtt.sourceforge.net/tracker/"
ESVN_REPO_URI="https://xbtt.svn.sourceforge.net/svnroot/xbtt/trunk/xbt"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="dev-libs/boost
	virtual/mysql
	sys-libs/zlib"
DEPEND="${RDEPEND}"

src_prepare() {
#Dirty hack to add -lz alongside with gentoo vars
	export LDFLAGS="-lz"
	sed -i -e \
		's:add_subdirectory("BT Test")::g' \
		CMakeLists.txt || die "CMakeLists.txt remove test failed!"

	sed -i -e \
		's:add_subdirectory("Client Command Line Interface")::g' \
		CMakeLists.txt || die "CMakeLists.txt remove client failed!"
}

src_install() {
	cmake-utils_src_install

	newinitd "${FILESDIR}/xbt_tracker.initd" xbt_tracker
	dodir /etc/xbtt
	insinto /etc/xbtt
	newins "${FILESDIR}/xbt_tracker.conf.default" xbt_tracker.conf.default
	newins "${FILESDIR}/xbt_tracker.sql" xbt_tracker.sql
	dodir /var/run/xbtt
	fowners xbtt:xbtt /var/run/xbtt
	fowners xbtt:xbtt /etc/xbtt
	fperms 750 /etc/xbtt
}

pkg_postinst() {
	enewgroup xbtt
	enewuser xbtt -1 -1 /dev/null xbtt
}
