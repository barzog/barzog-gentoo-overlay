# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5
PYTHON_COMPAT=( python{2_6,2_7,3_2,3_3} )

inherit distutils-r1 python-r1 eutils

REVISION="a13"
DESCRIPTION="StarPy Asterisk Protocols for Twisted"
HOMEPAGE="https://github.com/asterisk/starpy"
SRC_URI="https://github.com/asterisk/${PN}/archive/${PV}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 ppc ~x86 ~x86-fbsd"
IUSE=""

DEPEND=">=dev-python/twisted-core-10.1"
RDEPEND="${DEPEND}"

