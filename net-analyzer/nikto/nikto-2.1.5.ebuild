# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

inherit perl-module

DESCRIPTION="Web Server vulnerability scanner"
HOMEPAGE="http://www.cirt.net/Nikto2"
SRC_URI="http://www.cirt.net/nikto/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~x86 ~amd64 ~ppc ~sparc ~amd64-linux ~x86-linux ~x86-macos"
IUSE="ssl"

RDEPEND="
	!net-libs/libwhisker
	dev-lang/perl
	ssl? (
		dev-libs/openssl:0=
		dev-perl/Net-SSLeay
	)"

src_prepare() {
	sed -i -e 's:config.txt:nikto.conf:g' plugins/* || die
	sed -i -e 's:/etc/nikto.conf:/etc/nikto/nikto.conf:;' nikto.pl
	sed -i -e 's:# EXECDIR=/opt/nikto:EXECDIR=/usr/share/nikto:;' nikto.conf
	sed -i -e 's:# PLUGINDIR=/opt/nikto/plugins:PLUGINDIR=/usr/share/nikto/plugins:;' nikto.conf
	sed -i -e 's:# DBDIR=/opt/nikto/databases:DBDIR=/usr/share/nikto/databases:;' nikto.conf
	sed	-i -e 's:# TEMPLATEDIR=/opt/nikto/templates:TEMPLATEDIR=/usr/share/nikto/databases:;' nikto.conf
}

src_compile() { :; }

src_install() {
	insinto /etc/nikto
	doins nikto.conf

	dobin nikto.pl
	dosym nikto.pl /usr/bin/nikto

	insinto /usr/share/nikto
	doins -r plugins templates databases

	NIKTO_PMS='JSON-PP.pm LW2.pm'
	einfo "symlinking ${NIKTO_PMS} to ${VENDOR_LIB}"

	for _PM in ${NIKTO_PMS}; do
		_TARGET=${VENDOR_LIB}/${_PM}
		dosym /usr/share/nikto/plugins/${_PM} ${_TARGET}
	done

	dodoc docs/*.txt
	dohtml docs/nikto_manual.html
}
