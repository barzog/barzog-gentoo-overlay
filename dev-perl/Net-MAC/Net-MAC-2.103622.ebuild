# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

MODULE_AUTHOR=OLIVER
inherit perl-module

DESCRIPTION="Perl extension for representing and manipulating MAC addresses"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""
SRC_TEST="do"

DEPEND="virtual/perl-Carp
	virtual/perl-Test-Simple
	virtual/perl-ExtUtils-MakeMaker"
RDEPEND="${DEPEND}"
            