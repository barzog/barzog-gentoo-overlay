# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

MODULE_AUTHOR=RKINYON
inherit perl-module

DESCRIPTION="A pure perl multi-level hash/array DBM that supports transactions"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""
SRC_TEST="do"

DEPEND="dev-perl/Module-Build
	dev-perl/Test-Exception
	dev-perl/Test-Warn
	virtual/perl-Digest-MD5
	virtual/perl-File-Temp
	virtual/perl-File-Path
	dev-perl/Test-Deep"
RDEPEND="${DEPEND}"

