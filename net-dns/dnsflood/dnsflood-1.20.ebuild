# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

inherit eutils

DESCRIPTION="DNS Flood Detector was developed to detect abusive usage levels on high traffic nameservers and to enable quick response in halting the use of one's nameserver to facilitate spam."
HOMEPAGE="http://www.adotout.com/dnsflood.html"
LICENSE="GPL-2"

SRC_URI="http://www.adotout.com/${P}.tgz"
SLOT="0"
KEYWORDS="~x86 ~amd64 ~ppc ~ia64"

IUSE="debug messages"

DEPEND="net-libs/libpcap"

S="${WORKDIR}/dns_flood_detector_1.2"
QA_PRESTRIPPED="/usr/sbin/dns_flood_detector"

src_compile() {
	cd ${S}
	./configure.pl Linux
	emake || die "emake failed"
}

src_install() {
	dosbin dns_flood_detector
	doinitd dnsflood
}
