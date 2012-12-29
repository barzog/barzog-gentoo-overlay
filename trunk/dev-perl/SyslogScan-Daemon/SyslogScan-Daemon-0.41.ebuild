# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=3

MODULE_AUTHOR=MUIR
inherit perl-module
SRC_URI="mirror://cpan/authors/id/${MODULE_AUTHOR:0:1}/${MODULE_AUTHOR:0:2}/${MODULE_AUTHOR}/modules/${P}.tar.gz"

DESCRIPTION="Watch log files"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""
SRC_TEST="do"

DEPEND="dev-perl/Daemon-Generic
	dev-perl/Mail-SendVarious
	dev-perl/Plugins
	dev-perl/Event"
RDEPEND="${DEPEND}"
