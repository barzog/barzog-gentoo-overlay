# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-fs/aufs3/aufs3-3_p20120402.ebuild,v 1.1 2012/04/02 07:21:11 jlec Exp $

EAPI=4

inherit linux-mod multilib toolchain-funcs

DESCRIPTION="IXGBE kernel module driver"
HOMEPAGE="http://downloadcenter.intel.com/Detail_Desc.aspx?agr=Y&DwnldID=14687&lang=eng&wapkw=ixgbe"
SRC_URI="mirror://sourceforge/project/e1000/ixgbe%20stable/${PV}/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="nolro norsc"

BUILD_TARGETS="clean install"

MODULE_NAMES="ixgbe(drivers/net:${S}/src)"

src_compile() {
	CONFIG_CHECK="!CONFIG_IXGBE"
	cd "${S}/src"
	use nolro && CFLAGS_EXTRA+=-DIXGBE_NO_LRO
	use norsc && CFLAGS_EXTRA+=" -DIXGBE_NO_HW_RSC"
	emake CFLAGS_EXTRA="${CFLAGS_EXTRA}"
}

src_install() {
	linux-mod_src_install
	doman ixgbe.7
}