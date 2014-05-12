# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: 
EAPI=4

inherit user
DESCRIPTION="NetGauge is capable of measuring both gigabit and beyond, and allows our clients to operate with complete confidence, knowing that their unique branded version of our NetGauge Application is identical to the technology; and may even use the same server, as their customers on Speedtest.net."
HOMEPAGE="http://www.ookla.com/netgauge"
SRC_URI="http://cdn.speedtest.speedtest.net/netgauge/Linux.tgz"

LICENSE="no-source-code"
SLOT="0"

KEYWORDS="~amd64 ~x86"

IUSE=""

DEPEND=""
RDEPEND=""

S="${WORKDIR}"



src_install() {
	insinto /opt/netgauge
	doins OoklaServer.properties.default
	exeinto /opt/netgauge
	doexe OoklaServer
	newinitd "${FILESDIR}/netgauge.initd" netgauge
	fowners -R netgauge:netgauge /opt/netgauge
}

pkg_setup() {
	enewgroup netgauge
	enewuser netgauge -1 -1 /dev/null netgauge
}
