# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-block/hpacucli/hpacucli-9.0.24.0.ebuild,v 1.2 2012/05/15 05:57:27 ramereth Exp $

EAPI="4"

inherit rpm versionator pax-utils

MY_PV=$(replace_version_separator 2 '-')

SRC_URI_BASE="ftp://ftp.hp.com/pub/softlib2/software1/pubsw-linux"

DESCRIPTION="HP Array Configuration Utility Command Line Interface (HPACUCLI, formerly CPQACUXE)"
HOMEPAGE="http://h18000.www1.hp.com/products/servers/linux/documentation.html"
SRC_URI="x86? ( ${SRC_URI_BASE}/p414707558/v77371/${PN}-${MY_PV}.i386.rpm )
         amd64? ( ${SRC_URI_BASE}/p1257348637/v77370/${PN}-${MY_PV}.x86_64.rpm )"

LICENSE="hp-proliant-essentials"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="hardened"

DEPEND=""
RDEPEND="sys-apps/coreutils
	sys-process/procps
	>=sys-apps/util-linux-2.20.1
	x86? ( sys-libs/lib-compat )"

S="${WORKDIR}"

HPACUCLI_BASEDIR="/opt/hp/hpacucli"
HPACUCLI_LOCKDIR="/var/lock/hpacucli"

QA_PRESTRIPPED="/opt/hp/hpacucli/hpacucli.bin"
QA_EXECSTACK="opt/hp/hpacucli/libcpqimgr.so
	opt/hp/hpacucli/hpacucli.bin
	opt/hp/hpacucli/libcpqimgr-x86_64.so"

src_install() {
	local MY_S="${S}/opt/compaq/${PN}/bld"

	newsbin "${FILESDIR}"/"${PN}-setarch" hpacucli|| die

	exeinto "${HPACUCLI_BASEDIR}"
	newexe "${MY_S}"/.${PN} ${PN}.bin || die

	insinto "${HPACUCLI_BASEDIR}"
	doins "${MY_S}"/*.so || die

	ARCH=$(uname -m | sed -e 's/i.86/i386/')
	dodoc "${MY_S}/${PN}-${MY_PV}.${ARCH}.txt"
	doman "${S}"/usr/man/man?/*

	diropts -m0700
	dodir ${HPACUCLI_LOCKDIR}
	cat <<-EOF >"${T}"/45${PN}
		PATH=${HPACUCLI_BASEDIR}
		ROOTPATH=${HPACUCLI_BASEDIR}
		LDPATH=${HPACUCLI_BASEDIR}
		EOF
	doenvd "${T}"/45${PN}

	if use hardened; then
		pax-mark m "${D}/opt/hp/hpacucli/hpacucli.bin"
	fi
}

pkg_postinst() {
	if [ "${ROOT}" = "/" ] ; then
		PATH="${PATH}:/sbin" ldconfig -n "${HPACUCLI_BASEDIR}"
	fi

	ARCH=$(uname -m | sed -e 's/i.86/i386/')

	einfo
	einfo "For more information regarding this utility, please read"
	einfo "/usr/share/doc/${P}/${PN}-${MY_PV}.noarch.txt"
	einfo
}
