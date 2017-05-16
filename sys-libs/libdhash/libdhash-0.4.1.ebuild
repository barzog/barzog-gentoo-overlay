# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-libs/lib-compat/lib-compat-1.4.2.ebuild,v 1.4 2011/03/25 09:45:35 xarthisius Exp $

inherit eutils autotools

DESCRIPTION="Dynamic hash table implementation"
HOMEPAGE="https://releases.pagure.org/SSSD"
SRC_URI="https://releases.pagure.org/SSSD/ding-libs/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha x86 amd64"
IUSE=""

src_install() {
	emake install DESTDIR=${D}
}