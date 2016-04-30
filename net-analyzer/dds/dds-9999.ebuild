# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5
ECVS_SERVER="happy.kiev.ua:/cvs"
ECVS_MODULE="dds"
ECVS_TOPDIR="${DISTDIR}/cvs-src/${ECVS_MODULE}"

inherit autotools eutils cvs

MY_P=${PN}_${PV}
DESCRIPTION="DoS/DDoS Detector"
HOMEPAGE="http://gul-tech.livejournal.com/5959.html"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"
IUSE="+perl +snmp vlans pcap debug"

DEPEND=""
RDEPEND=${DEPEND}

S=${WORKDIR}/${ECVS_MODULE}

src_configure() {
	econf $(use_with perl) $(use_with snmp) $(use_with vlans) $(use_with pcap) $(use_with debug)
}

src_install() {
	dobin dds
	doman dds.8

	insinto /etc/dds
	doins dds.conf
	doins dds.pl

        newconfd "${FILESDIR}/dds.conf" ${PN}
	newinitd "${FILESDIR}/dds.initd" ${PN}
}
