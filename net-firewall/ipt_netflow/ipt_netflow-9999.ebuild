# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header:

EAPI="5"

inherit git-2 eutils linux-info linux-mod multilib toolchain-funcs

EGIT_REPO_URI="git://github.com/aabc/ipt-netflow"

DESCRIPTION="Netflow iptables module"
HOMEPAGE="https://github.com/aabc/ipt-netflow"
SRC_URI=""


LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"

IUSE="pax_kernel ipv6"

RDEPEND="net-firewall/iptables"
DEPEND="${RDEPEND}
	virtual/linux-sources
	virtual/pkgconfig"

BUILD_TARGETS="all"
CONFIG_CHECK="~IP_NF_IPTABLES"
MODULE_NAMES="ipt_NETFLOW(ipt_netflow:${S})"

IPT_LIB="/usr/$(get_libdir)/xtables"

src_configure() {
	local IPT_VERSION="$($(tc-getPKG_CONFIG) --modversion xtables)"
	# econf can not be used, cause configure script fails when see unknown parameter
	# ipt-src need to be defined, see bug #455984
	./configure \
		--ipt-lib="${IPT_LIB}" \
		--ipt-ver="${IPT_VERSION}" \
		--kdir="${KV_DIR}" \
		--kver="${KV_FULL}" \
		--enable-natevents \
	|| die 'configure failed'
}

src_compile() {
	local ARCH="$(tc-arch-kernel)"
	emake CC="$(tc-getCC)" all
}

src_install() {
	linux-mod_src_install
	exeinto "${IPT_LIB}"
	doexe libipt_NETFLOW.so
	if use ipv6; then
		doexe libip6t_NETFLOW.so
	fi
	doheader ipt_NETFLOW.h
	dodoc README*
}
