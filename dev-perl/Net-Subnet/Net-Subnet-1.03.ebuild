# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

MODULE_AUTHOR=JUERD
inherit perl-module

DESCRIPTION="Fast IP-in-subnet matcher for IPv4 and IPv6, CIDR or mask.  "
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""
SRC_TEST="do"

DEPEND="dev-perl/Socket6"
RDEPEND=${DEPENDS}
