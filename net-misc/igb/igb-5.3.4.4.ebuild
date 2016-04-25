# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-fs/aufs3/aufs3-3_p20120402.ebuild,v 1.1 2012/04/02 07:21:11 jlec Exp $

EAPI=4

inherit linux-mod multilib toolchain-funcs

DESCRIPTION="IGB kernel module driver"
HOMEPAGE="http://www.intel.com/support/network/adapter/pro100/sb/CS-032498.htm"
SRC_URI="mirror://sourceforge/project/e1000/igb%20stable/${PV}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
BUILD_TARGETS="clean install"

MODULE_NAMES="igb(drivers/net:${S}/src)"

src_compile() {
	CONFIG_CHECK="!CONFIG_IGB"
	cd "${S}/src"
	BUILD_KERNEL=${KV_FULL} emake
}

src_install() {
	linux-mod_src_install
	doman igb.7
}
