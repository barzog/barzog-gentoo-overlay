# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

MODULE_AUTHOR=ZWON
inherit perl-module

DESCRIPTION="Perl extension to access REDIS database"
LICENSE="|| ( Artistic GPL-2 )"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""
SRC_TEST="do"

DEPEND="dev-perl/RedisDB-Parser
dev-perl/IO-Socket-IP"
RDEPEND="${DEPEND}"


