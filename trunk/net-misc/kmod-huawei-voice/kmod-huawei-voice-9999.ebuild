# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/app-emulation/kvm-kmod/kvm-kmod-88-r1.ebuild,v 1.1 2009/07/27 13:57:06 dang Exp $

EAPI="2"

inherit git-2 eutils linux-mod multilib

EGIT_PROJECT="kmod-huawei-voice"
EGIT_REPO_URI="git://github.com/Novax/kmod-huawei-voice.git"
DESCRIPTION="Huawei E150 fixed one-way voice kernel module"
HOMEPAGE="http://wiki.e1550.mobi/doku.php?id=troubleshooting#one_way_voice_on_huawei_e150"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64 ~ppc ~ia64"
IUSE=""

RDEPEND="virtual/modutils"
DEPEND="${RDEPEND}
	 virtual/linux-sources"

BUILD_TARGETS="all"
ARCH=$(tc-arch-kernel)

MODULE_NAMES="option_huawei(option_huawei:${S})
                huawei_voice(huawei_voice:${S}"

pkg_setup() {
        linux-info_pkg_setup
        CONFIG_CHECK="!CONFIG_USB_SERIAL_OPTION"
        linux-mod_pkg_setup
}

src_prepare() {
        cd ${S}
        sed -i 's:option.o:option_huawei.o:' Makefile
        mv option.c option_huawei.c
}

pkg_posinst() {
        ewarn "In order to use modified option module you should do following:"
        ewarn "Disable load/use of stock option module"
        ewarn "Load option_huawei and huawei_voice modules instead"
}
