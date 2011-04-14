# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="3"
PYTHON_DEPEND="2"
SUPPORT_PYTHON_ABIS="1"
RESTRICT_PYTHON_ABIS="3.* *-jython"

inherit distutils eutils

DESCRIPTION="higher-level ftp library using ftplib"
HOMEPAGE="http://ftputil.sschwarzer.net/trac/wiki"
SRC_URI="http://ftputil.sschwarzer.net/trac/raw-attachment/wiki/Download/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 ppc x86 ~x86-fbsd"
IUSE=""

DEPEND=""
RDEPEND=""

