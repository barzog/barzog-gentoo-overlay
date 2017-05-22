# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="5"

inherit cmake-utils git-2
DESCRIPTION="BitTorrent tracker written in C++"
HOMEPAGE="https://github.com/shakahl/xbt"
SRC_URI=""
EGIT_REPO_URI="https://github.com/shakahl/xbt.git"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""
#WORKDIR="${PORTAGE_BUILDDIR}/work/xbt"
#PN="xbt"
#S="${WORKDIR}/xbt"

RDEPEND="dev-libs/boost
	virtual/mysql
	sys-libs/zlib"
DEPEND="${RDEPEND}"

src_prepare() {
	cmake_comment_add_subdirectory "BT Test"
	cmake_comment_add_subdirectory "Client Command Line Interface"
	S="${S}/xbt"
}

src_install() {
	cmake-utils_src_install

	newinitd "${FILESDIR}/xbt_tracker.initd" xbt_tracker
	dodir /etc/xbtt
	insinto /etc/xbtt
	newins "${FILESDIR}/xbt_tracker.conf.default" xbt_tracker.conf.default
	newins "${FILESDIR}/xbt_tracker.sql" xbt_tracker.sql
	fowners xbtt:xbtt /etc/xbtt
	fperms 750 /etc/xbtt
}

pkg_postinst() {
	enewgroup xbtt
	enewuser xbtt -1 -1 /dev/null xbtt
}
