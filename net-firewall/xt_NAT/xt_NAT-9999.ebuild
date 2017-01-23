# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header:

EAPI="5"

inherit git-2 eutils linux-info linux-mod multilib toolchain-funcs

EGIT_REPO_URI="git://git.telecom.by/xt-NAT"

DESCRIPTION="Full Cone NAT iptables module"
HOMEPAGE="http://telecom.by"
SRC_URI=""


LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"

IUSE=""

RDEPEND="net-firewall/iptables"
DEPEND="${RDEPEND}
        virtual/linux-sources
        virtual/pkgconfig"

BUILD_TARGETS="all"
CONFIG_CHECK="~IP_NF_IPTABLES"
MODULE_NAMES="xt_NAT(xt_NAT:${S})"

IPT_LIB="/usr/$(get_libdir)/xtables"

src_compile() {
        local ARCH="$(tc-arch-kernel)"
        emake CC="$(tc-getCC)" KVER="${KV_FULL}"
}

src_install() {
        linux-mod_src_install
        exeinto "${IPT_LIB}"
        doexe libxt_NAT.so
        doheader xt_NAT.h
}

