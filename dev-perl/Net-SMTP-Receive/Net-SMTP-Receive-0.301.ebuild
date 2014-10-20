# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

MODULE_AUTHOR=MUIR
inherit perl-module
SRC_URI="mirror://cpan/authors/id/${MODULE_AUTHOR:0:1}/${MODULE_AUTHOR:0:2}/${MODULE_AUTHOR}/modules/${P}.tar.gz"

DESCRIPTION="receive mail via SMTP"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""
SRC_TEST="do"

DEPEND="dev-perl/File-Flock
	dev-perl/Net-Ident
	virtual/perl-Storable
	dev-perl/File-Sync
	dev-perl/File-Slurp
	dev-perl/Time-modules"
RDEPEND="${DEPEND}"
