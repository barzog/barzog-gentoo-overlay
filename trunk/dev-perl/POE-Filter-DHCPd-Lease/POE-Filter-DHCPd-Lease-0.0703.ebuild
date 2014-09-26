# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

MODULE_AUTHOR=RDRAKE
inherit perl-module

DESCRIPTION="parses leases from isc dhcpd leases file"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""
SRC_TEST="do"

DEPEND="virtual/perl-ExtUtils-MakeMaker
	dev-perl/POE
	virtual/perl-Time-Local"
RDEPEND="${DEPEND}"