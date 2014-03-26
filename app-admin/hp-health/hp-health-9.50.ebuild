# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit eutils toolchain-funcs rpm

DESCRIPTION="HP System Health Application and Insight Management Agents Package (Formerly HPASM)"
HOMEPAGE="http://h18000.www1.hp.com/products/servers/linux/documentation.html"
LICENSE="hp-value"
KEYWORDS="amd64 x86"
IUSE="ssl snmp X"
DEPEND="${RDEPEND}
        mail-client/mailx
        app-arch/rpm2targz
        sys-apps/pciutils
        sys-libs/ncurses
        dev-lang/python
        sys-apps/ethtool
        sys-apps/lm_sensors
        snmp? ( net-analyzer/net-snmp )
        ssl? ( dev-libs/openssl )"

RDEPEND="${DEPEND}
        app-arch/tar
        sys-apps/sed"

SRC_URI_BASE="http://downloads.linux.hp.com/downloads/SPP/RedHatEnterpriseServer/6.5"
SRC_URI="x86? ( ${SRC_URI_BASE}/i686/current/${P}-1628.33.rhel6.i686.rpm )
                amd64? ( ${SRC_URI_BASE}/x86_64/current/${P}-1628.32.rhel6.x86_64.rpm )"

HP_HOME="/opt/hp"

SLOT="0"
S="${WORKDIR}"

QA_EXECSTACK="${HP_HOME:1}/hp-health/bin/hpasmpld
	${HP_HOME:1}/hp-health/bin/IrqRouteTbl
	${HP_HOME:1}/hp-health/bin/hpasmlited
	${HP_HOME:1}/hp-health/bin/hpasmxld
	usr/$(get_libdir)/libhpev64.so.1.0
	usr/sbin/hplog"
QA_PRESTRIPPED="/opt/hp/hp-health/bin/hpasmlited
    /opt/hp/hp-health/bin/hpasmpld
    /opt/hp/hp-health/bin/hpasmxld
    /opt/hp/hp-health/bin/hp-asrd
    /usr/lib64/libcpqci64.so.3.0
    /usr/lib64/libhpev64.so.1.0
    /usr/lib64/libhpasmintrfc64.so.3.0
    /usr/sbin/hpasmcli
    /usr/sbin/hpbootcfg
    /usr/sbin/hplog
    /usr/sbin/hpuid"

src_unpack() {
	rpm_src_unpack
        cd ${S}
#	find ./ -type l -exec rm -f {} \;
}

src_install() {
        cd "${S}"
	dodir ${HP_HOME}
        cp -Rdp "${S}"${HP_HOME}/* "${D}${HP_HOME}"
        dolib.so ./usr/$(get_libdir)/*.so*
	dodir /var/log/hp-health
	dodir /var/spool/compaq
	dodir /var/spool/hp-health
	doman usr/share/man/man?/*
	dosbin sbin/*
}

pkg_postinst() {
        if [ "${ROOT}" == "/" ] ; then
                /sbin/ldconfig
        fi
        einfo
        if ! use snmp ; then
                einfo "If you want to use the web agent and other features"
                einfo "then configure your /usr/share/snmp/snmpd.conf"
                einfo
                einfo "It is not required to have net-snmp"
                einfo "running for basic hpasm functionality."
                einfo
        fi
        einfo "You now need to execute /etc/init.d/hpasm configure"
        einfo "in order to configure the installed package."
        einfo
} 
