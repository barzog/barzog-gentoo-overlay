# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

MODULE_AUTHOR=GUGU
inherit perl-module

DESCRIPTION="Use Cache::Memcached::Fast like a hash."
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""
SRC_TEST="do"

DEPEND="virtual/perl-ExtUtils-MakeMaker
	dev-perl/Cache-Memcached-Fast"
RDEPEND="${DEPEND}"

