# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-fs/aufs3/aufs3-3_p20120402.ebuild,v 1.1 2012/04/02 07:21:11 jlec Exp $

EAPI=4

inherit linux-mod multilib toolchain-funcs

DESCRIPTION="Linux Base Driver for the Intel(R) Ethernet Controller XL710 Family"
HOMEPAGE="https://downloadcenter.intel.com/product/83965/Intel-Ethernet-Converged-Network-Adapter-X710-DA4"
SRC_URI="mirror://sourceforge/project/e1000/i40e%20stable/${PV}/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

BUILD_TARGETS="clean install"

MODULE_NAMES="i40e(drivers/net:${S}/src)"

src_compile() {
	ARCH="$(tc-arch-kernel)"
	CONFIG_CHECK="!CONFIG_I40E"
	cd "${S}/src"
	BUILD_KERNEL=${KV_FULL} emake
}

src_install() {
	linux-mod_src_install
	doman i40e.7
}

