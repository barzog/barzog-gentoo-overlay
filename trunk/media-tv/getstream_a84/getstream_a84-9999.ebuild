# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=2

inherit mercurial autotools-utils

DESCRIPTION="Fork of getstream with enhanced functionality for receive/decrypt/transmit DVB streams"
HOMEPAGE="https://bitbucket.org/cesbo/getstream_a84/wiki/Home"
LICENSE="GPL-2"

SLOT="0"
KEYWORDS="~x86 ~amd64 ~ppc ~ia64"

EHG_REPO_URI="https://bitbucket.org/cesbo/getstream_a84"
EHG_QUIET="ON"
DEPEND="dev-vcs/mercurial
	dev-libs/libevent"
RDEPEND="${DEPEND}"

PATCHES=("${FILESDIR}/getstream_a84.patch")
