# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

MODULE_AUTHOR=DIEDERICH
inherit perl-module

DESCRIPTION="Tie interface to Net::DNS"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""
SRC_TEST="do"

DEPEND="dev-perl/Net-DNS"
RDEPEND="${DEPEND}"

