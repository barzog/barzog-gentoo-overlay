# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5
PYTHON_COMPAT=( python{2_6,2_7,3_2,3_3} )

RDEPEND="${DEPEND}
	 net-libs/libpcap"

inherit distutils-r1 python-r1

DESCRIPTION="Python pcap extension"
HOMEPAGE="http://oss.coresecurity.com/projects/pcapy.html"
SRC_URI="https://github.com/CoreSecurity/${PN}/archive/${PV}.tar.gz"

LICENSE="Apache-1.1"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""
