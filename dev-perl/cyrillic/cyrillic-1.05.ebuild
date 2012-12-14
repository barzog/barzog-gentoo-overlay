# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=3

MODULE_AUTHOR=JNEYSTADT
inherit perl-module

DESCRIPTION="WWW Cyrillic Encoding Suite is a set of PERL packages and scripts, intended to be used by WWW CGIs."
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""
SRC_TEST="do"

DEPEND="dev-perl/Unicode-Map8
	dev-perl/Unicode-String"
RDEPEND="${DEPEND}"

