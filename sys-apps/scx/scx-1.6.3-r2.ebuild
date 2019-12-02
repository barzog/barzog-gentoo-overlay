# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=3
inherit multilib

DESCRIPTION="Operations Management Suite Agent for Linux"
HOMEPAGE="https://github.com/Microsoft/OMS-Agent-for-Linux"
SRC_URI="http://srv-repo-01.main.velcom.by:8080/gentoo/source_files/scx-1.6.3.1079.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="-* ~amd64"

USE=""
DEPEND=">=dev-libs/openssl-1.1.0"
RDEPEND="${DEPEND}"

src_install() {
                cp -vR ${WORKDIR}/* ${D}/ || die "installing data failed"
}
pkg_config() {
    if [! -e "${ROOT}"/etc/opt/omi/ssl/omi-host-`hostname`.pem ] ; then
        "${ROOT}"/opt/microsoft/scx/bin/tools/scxsslconfig -f -h \
        `/bin/hostname` -d `/bin/hostname -d`
    else
        einfo "SSL cert already exists"
    fi
    echo > /etc/opt/microsoft/scx/conf/scx-release
    echo "OSName=Gentoo" >> /etc/opt/microsoft/scx/conf/scx-release
    echo "OSVersion=x86_64" >> /etc/opt/microsoft/scx/conf/scx-release
    echo "OSFullName=Gentoo (x86_64)" >> /etc/opt/microsoft/scx/conf/scx-release
    echo "OSAlias=UniversalR" >> /etc/opt/microsoft/scx/conf/scx-release
    echo "OSManufacturer=" >> /etc/opt/microsoft/scx/conf/scx-release	
    touch /etc/opt/microsoft/scx/conf/disablereleasefileupdates
}
