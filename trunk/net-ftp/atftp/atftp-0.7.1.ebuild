# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/net-ftp/atftp/atftp-0.7-r2.ebuild,v 1.6 2012/05/13 11:13:32 swift Exp $

EAPI=2

inherit eutils autotools-utils

DESCRIPTION="Advanced TFTP implementation client/server"
HOMEPAGE="http://sourceforge.net/projects/atftp/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~arm ~ppc ~ppc64 ~s390 ~sparc x86"
IUSE="selinux tcpd readline pcre"

DEPEND="tcpd? ( sys-apps/tcp-wrappers )
	selinux? ( sec-policy/selinux-tftp )
	readline? ( sys-libs/readline )
	pcre? ( dev-libs/libpcre )"
RDEPEND="${DEPEND}
	!net-ftp/netkit-tftp
	!net-ftp/tftp-hpa"
PATCHES=("${FILESDIR}/blksize.patch")

src_compile() {
	econf \
		$(use_enable tcpd libwrap) \
		$(use_enable readline libreadline) \
		$(use_enable pcre libpcre) \
		--enable-mtftp \
		|| die "./configure failed"
	emake CFLAGS="${CFLAGS}" || die
}

src_install() {
	emake install DESTDIR="${D}" || die "Installation failed"
	newinitd "${FILESDIR}"/atftp.init atftp
	newconfd "${FILESDIR}"/atftp.confd atftp

	dodoc README* BUGS FAQ Changelog INSTALL TODO
	dodoc "${S}"/docs/*

	docinto test
	cd "${S}"/test
	dodoc load.sh mtftp.conf pcre_pattern.txt test.sh test_suite.txt
}
