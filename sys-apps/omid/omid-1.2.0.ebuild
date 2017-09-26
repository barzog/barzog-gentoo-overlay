# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=3
inherit multilib pam

DESCRIPTION="Operations Management Suite Agent for Linux"
HOMEPAGE="https://github.com/Microsoft/OMS-Agent-for-Linux"
SRC_URI="http://falcon-cl4.telecom.by:8080/admin/source_files/omi-1.2.0.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="-* ~amd64"

USE=""
DEPEND=""
RDEPEND="${DEPEND}
	sys-apps/scx"

src_install() {
		cp -vR ${WORKDIR}/* ${D}/ || die "installing data failed"
		newinitd "${FILESDIR}/${PN}.init" "${PN}"
		newpamd "${FILESDIR}/omi.pam" omi
}
