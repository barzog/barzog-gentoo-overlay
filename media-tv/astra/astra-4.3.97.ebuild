# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"
SLOT="0"

DESCRIPTION="Astra DVB media streamer"
HOMEPAGE="https://cesbo.com/wiki/display/astra/Astra.+Quick+Start"
SRC_URI="https://bitbucket.org/cesbo/astra/get/${PN}-4.tar.gz"
S="${WORKDIR}/cesbo-astra-735a0cb14b11"

QA_PRESTRIPPED="/usr/bin/astra"

inherit eutils user


src_configure() {
	cd ${S}
	./configure.sh LDFLAGS="-lavcodec -lavutil"
	sed -i '/@rm -f \/usr\/bin\/$</d' Makefile
}

src_compile() {
	emake
}

src_install() {
	dobin astra
	keepdir /etc/astra/helpers
	insinto /etc/astra/helpers
	doins helpers/*.lua
	newinitd "${FILESDIR}/astra.initd" astra
	newconfd "${FILESDIR}/astra.confd" astra
}

pkg_setup() {
	enewgroup astra
	enewuser astra -1 -1 /dev/null astra
}
