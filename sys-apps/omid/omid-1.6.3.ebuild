# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=3
inherit multilib pam

DESCRIPTION="Operations Management Suite Agent for Linux"
HOMEPAGE="https://github.com/Microsoft/OMS-Agent-for-Linux"
SRC_URI="http://srv-repo-01.main.velcom.by:8080/gentoo/source_files/omi-1.6.3.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="-* ~amd64"

USE=""
DEPEND=">=dev-libs/openssl-1.1.0"
RDEPEND="${DEPEND}
        sys-apps/scx"

src_install() {
                cp -vR ${WORKDIR}/* ${D}/ || die "installing data failed"
                newinitd "${FILESDIR}/${PN}.init" "${PN}"
                newpamd "${FILESDIR}/omi.pam" omi
}
