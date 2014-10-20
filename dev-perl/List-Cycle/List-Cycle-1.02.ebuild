# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

MODULE_AUTHOR=PETDANCE
inherit perl-module

DESCRIPTION="Objects for cycling through a list of values"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""
SRC_TEST="do"

DEPEND="virtual/perl-Carp"
RDEPEND="${DEPEND}"
            