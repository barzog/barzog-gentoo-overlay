# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=3

MODULE_AUTHOR=JHTHORSEN
inherit perl-module

DESCRIPTION="Interacts with ISC DHCPd"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""
SRC_TEST="do"

DEPEND="virtual/perl-ExtUtils-MakeMaker
	>=dev-perl/MooseX-Types-Path-Class-0.05
	>=dev-perl/NetAddr-IP-4.0
	>=virtual/perl-Time-HiRes-1.9
	dev-perl/POE-Filter-DHCPd-Lease"
RDEPEND="${DEPEND}"
