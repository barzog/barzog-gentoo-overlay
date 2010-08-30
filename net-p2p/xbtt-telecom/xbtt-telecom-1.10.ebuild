# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="1"

ESVN_REPO_URI="svn://lost.telecom.by/torrents.telecom.by/branches/minsk/release-1.10/scripts"
ESVN_USER="anon"
ESVN_PASSWORD="anon"
inherit subversion

DESCRIPTION="XBT BitTorrent tracker Atlant-Telecom release"
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
	cd xbt
	$(tc-getCXX) -DNDEBUG -I ../misc -I . -O3 -o xbt_tracker \
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
        md5.cpp \
        "XBT Tracker.cpp" \
        `mysql_config --libs` && strip xbt_tracker
}

src_install() {
	newsbin Tracker/xbt_tracker xbt_tracker-telecom
	newinitd "${FILESDIR}/xbtt.initd" xbtt-telecom
	dodir /etc/xbtt-telecom
	insinto /etc/xbtt-telecom.by
	newins Tracker/xbt_tracker.conf.default xbt_tracker.conf.default
}