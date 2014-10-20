# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="5"

MODULE_AUTHOR=JANPAZ

inherit perl-module

DESCRIPTION="DBI driver for XBase compatible database files"

SLOT="0"
KEYWORDS="~amd64"
IUSE="test"

DEPEND="virtual/perl-Module-Build
	test? ( virtual/perl-Test-Simple )
"
RDEPEND=""

SRC_TEST="do"
