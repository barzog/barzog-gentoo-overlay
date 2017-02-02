# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

MODULE_AUTHOR=PIOTO
inherit perl-module

DESCRIPTION="Determine the current uptime, in seconds, and load averages, across different *NIX architectures"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""
SRC_TEST="do"

DEPEND="dev-perl/Module-Build"
RDEPEND="${DEPEND}"
            