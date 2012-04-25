# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="4"

MODULE_AUTHOR=MEWP

inherit perl-module

DESCRIPTION="DBI driver for XBase compatible database files"

SLOT="0"
KEYWORDS="~amd64"
IUSE="test"

DEPEND="virtual/perl-Module-Build
	test? ( virtual/perl-Test-Simple )
	dev-db/freetds"
RDEPEND="${DEPEND}"

SRC_TEST="do"

src_configure() {
	export SYBASE=/usr
	perl-module_src_configure
}
