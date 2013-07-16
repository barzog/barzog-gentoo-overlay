# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="1"

SRC_URI=""
EGIT_REPO_URI="ssh://git@git.telecom.by/xbtt-telecom"
inherit git-2 toolchain-funcs user

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
        `mysql_config --libs`
}

pkg_setup() {
	enewgroup xbtt
	enewuser xbtt -1 -1 /dev/null xbtt
}

src_install() {
	newsbin xbt/xbt_tracker xbt_tracker-telecom
	newinitd "${FILESDIR}/xbtt.initd" xbtt-telecom
	dodir /etc/xbtt-telecom
	insinto /etc/xbtt-telecom
	newins xbt/xbt_tracker.conf.default xbt_tracker.conf.default
        dodir /var/run/xbtt
        fowners xbtt:xbtt /var/run/xbtt
        fowners xbtt:xbtt /etc/xbtt-telecom
        fperms 750 /etc/xbtt-telecom
}