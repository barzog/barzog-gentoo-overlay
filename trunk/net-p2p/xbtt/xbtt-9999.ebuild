# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="1"

ESVN_REPO_URI="https://xbtt.svn.sourceforge.net/svnroot/xbtt/trunk/xbt"

inherit subversion

DESCRIPTION="XBT BitTorrent tracker"
HOMEPAGE="http://xbtt.sourceforge.net/tracker/"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
DEPEND=""

RDEPEND="dev-libs/boost
	dev-util/cmake
	virtual/mysql
	sys-libs/zlib"

src_compile() {
	cd Tracker
	$(tc-getCXX) -DNDEBUG -I ../misc -I . -O3 -o xbt_tracker  \
        ../misc/sql/database.cpp \
        ../misc/sql/sql_query.cpp \
        ../misc/sql/sql_result.cpp \
        ../misc/bt_misc.cpp \
        ../misc/bvalue.cpp \
        ../misc/sha1.cpp \
        ../misc/socket.cpp \
        ../misc/virtual_binary.cpp \
        ../misc/xcc_z.cpp \
        config.cpp \
        connection.cpp \
        epoll.cpp \
        server.cpp \
        tcp_listen_socket.cpp \
        tracker_input.cpp \
        transaction.cpp \
        udp_listen_socket.cpp \
        "XBT Tracker.cpp" \
        `mysql_config --libs` && strip xbt_tracker || die "compile xbtt failed"
}

src_install() {
	dosbin Tracker/xbt_tracker
	newinitd "${FILESDIR}/xbtt.initd" xbtt
	dodir /etc/xbtt
	insinto /etc/xbtt
	newins Tracker/xbt_tracker.conf.default xbt_tracker.conf.default
}