# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

MODULE_AUTHOR=OALDERS
inherit perl-module

DESCRIPTION="OATH One Time Passwords"

SLOT="0"
KEYWORDS="alpha amd64 ia64 ~ppc ppc64 sparc x86"
IUSE=""

RDEPEND=""
DEPEND="${RDEPEND}
        dev-perl/Module-Build
	dev-perl/Moose
	dev-perl/Digest-HMAC
	dev-perl/Digest-SHA1"

SRC_TEST="do"

export OPTIMIZE="$CFLAGS"
