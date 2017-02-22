# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5
PYTHON_COMPAT=( python{2_6,2_7,3_2,3_3} )

inherit distutils-r1 python-r1 eutils

DESCRIPTION="Python for asterisk"
HOMEPAGE="http://sourceforge.net/projects/pyst/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ppc ~x86 ~x86-fbsd"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"

