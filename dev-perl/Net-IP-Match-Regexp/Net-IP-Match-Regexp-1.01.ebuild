# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

MODULE_AUTHOR=CDOLAN
inherit perl-module

DESCRIPTION="Efficiently match IP addresses against ranges"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""
SRC_TEST="do"

DEPEND="dev-perl/Module-Build"
RDEPEND="${DEPEND}"