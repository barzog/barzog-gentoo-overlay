# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

inherit eutils

DESCRIPTION="DNSPerf “self-paces” the DNS query load to simulate network conditions."
HOMEPAGE="http://nominum.com/measurement-tools/"
LICENSE="GPL-2"

SRC_URI="ftp://ftp.nominum.com/pub/nominum/${PN}/${PV}/${PN}-src-${PV}-1.tar.gz"
SLOT="0"
KEYWORDS="~x86 ~amd64 ~ppc ~ia64"

S="${WORKDIR}/${PN}-src-${PV}-1"

IUSE="queryparse"

DEPEND=">=net-dns/bind-9.4.0
		queryparse? ( dev-python/dnspython dev-python/pcapy )
		sci-visualization/gnuplot"

src_install() {
	dobin dnsperf resperf resperf-report
	doman resperf.1	dnsperf.1
	dodoc README RELEASE_NOTES doc/*
	if use queryparse; then
		dobin contrib/queryparse/queryparse
		doman contrib/queryparse/queryparse.1
	fi
}
