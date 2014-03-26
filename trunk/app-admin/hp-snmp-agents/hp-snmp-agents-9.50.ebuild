# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit eutils toolchain-funcs rpm

DESCRIPTION="HP System SNMP agents"
HOMEPAGE="http://h18000.www1.hp.com/products/servers/linux/documentation.html"
LICENSE="hp-value"
KEYWORDS="amd64 x86"
IUSE=""
DEPEND="${RDEPEND}
        mail-client/mailx
        app-arch/rpm2targz
        sys-apps/pciutils
        sys-libs/ncurses
        dev-lang/python
        sys-apps/ethtool
        sys-apps/lm_sensors
        net-analyzer/net-snmp"

RDEPEND="${DEPEND}
        app-arch/tar
        sys-apps/sed"

SRC_URI_BASE="http://downloads.linux.hp.com/downloads/SPP/RedHatEnterpriseServer/6.5"
SRC_URI="x86? ( ${SRC_URI_BASE}/i686/current/${P}-2564.36.rhel6.i686.rpm )
                amd64? ( ${SRC_URI_BASE}/x86_64/current/${P}-2564.40.rhel6.x86_64.rpm )"

HP_HOME="/opt/hp"

SLOT="0"
S="${WORKDIR}"

QA_PRESTRIPPED="${HP_HOME:1}/hp-snmp-agents/nic/bin/cmanicd
    ${HP_HOME:1}/hp-snmp-agents/server/bin/cmaperfd
    ${HP_HOME:1}/hp-snmp-agents/server/bin/cmapeerd
    ${HP_HOME:1}/hp-snmp-agents/server/bin/cmahostd
    ${HP_HOME:1}/hp-snmp-agents/server/bin/cmasm2d
    ${HP_HOME:1}/hp-snmp-agents/server/bin/cmahealthd
    ${HP_HOME:1}/hp-snmp-agents/server/bin/cmastdeqd
    ${HP_HOME:1}/hp-snmp-agents/server/bin/cmathreshd
    ${HP_HOME:1}/hp-snmp-agents/webagent/csginkgo
    ${HP_HOME:1}/hp-snmp-agents/storage/bin/cmaided
    ${HP_HOME:1}/hp-snmp-agents/storage/bin/cmaeventd
    ${HP_HOME:1}/hp-snmp-agents/storage/bin/libcpqimgr-x86_64.so
    ${HP_HOME:1}/hp-snmp-agents/storage/bin/cmasasd
    ${HP_HOME:1}/hp-snmp-agents/storage/bin/cmaidad
    ${HP_HOME:1}/hp-snmp-agents/storage/bin/cmafcad
    ${HP_HOME:1}/hp-snmp-agents/storage/bin/cmascsid
    /usr/lib64/libcmaX.so.1.0
    /usr/lib64/libcmaX64.so.1.0
    /usr/lib64/libcmaconf64.so.1.0
    /usr/lib64/libcmapeer64.so.1.0
    /usr/lib64/libcmacommon64.so.1.0"

QA_EXECSTACK="${HP_HOME:1}/hp-snmp-agents/storage/bin/cmaided
    ${HP_HOME:1}/hp-snmp-agents/storage/bin/libcpqimgr-x86_64.so
    ${HP_HOME:1}/hp-snmp-agents/storage/bin/cmasasd
    ${HP_HOME:1}/hp-snmp-agents/storage/bin/cmaidad
    ${HP_HOME:1}/hp-snmp-agents/storage/bin/cmascsid"

src_unpack() {
	rpm_src_unpack
}

src_install() {
        cd "${S}"
        dodir ${HP_HOME}
        cp -Rdp "${S}"${HP_HOME}/* "${D}${HP_HOME}"
        dolib.so ./usr/$(get_libdir)/*.so*
        doman usr/share/man/man?/*
                                            
}

pkg_postinst() {
        if [ "${ROOT}" == "/" ] ; then
            /sbin/ldconfig
        fi
}
                         