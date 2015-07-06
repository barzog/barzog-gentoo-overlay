# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="3"
PYTHON_DEPEND="2"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="3.* *-jython"

inherit distutils eutils git-2

DESCRIPTION="StarPy Asterisk Protocols for Twisted"
HOMEPAGE="https://github.com/asterisk/starpy"
EGIT_REPO_URI="https://github.com/asterisk/starpy"
LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86 ~x86-fbsd"
IUSE=""

DEPEND=">=dev-python/twisted-core-10.1"
RDEPEND="${DEPEND}"

