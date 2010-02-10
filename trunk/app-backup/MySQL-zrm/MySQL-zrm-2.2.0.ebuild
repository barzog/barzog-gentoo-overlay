# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

#inherit perl-module

DESCRIPTION="Zmanda MySQL backup/recovery tool"
HOMEPAGE="http://mysqlbackup.zmanda.com/"
PV="2.2"
SRC_URI="http://www.zmanda.com/downloads/community/ZRM-MySQL/$PV/Source/${P}-release.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

DEPEND="dev-lang/perl dev-perl/DBI dev-perl/XML-Parser"

src_install() {
	cd ${WORKDIR}/usr/share/man
	doman man1/* man5/*

	cd ${WORKDIR}/usr/share/doc/${P}
	dodoc *

	into /usr
	dobin ${WORKDIR}/usr/bin/*

	insinto /usr/lib/mysql-zrm
	doins -r ${WORKDIR}/usr/lib/mysql-zrm/*
 
	insinto /etc
	doins -r ${WORKDIR}/etc/*

	insinto /usr/share/mysql-zrm
	insopts -m 700
	doins -r ${WORKDIR}/usr/share/mysql-zrm/*

	insinto /
	dodir /var/log/mysql-zrm
	dodir /var/lib/mysql-zrm

	fperms 600 /etc/mysql-zrm/mysql-zrm.conf
	fperms 600 /etc/mysql-zrm/mysql-zrm-reporter.conf
	fperms 600 /etc/mysql-zrm/RSS.header
}
