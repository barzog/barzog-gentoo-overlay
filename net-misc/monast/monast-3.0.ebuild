# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="3"

BETA_REV="b4"

DESCRIPTION="Monast is a monitoring interface which acts as an operator panel for Asterisk."
HOMEPAGE="http://monast.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/Monast%20for%20Asterisk%201.4%2C%201.6%20and%201.8/${PV}${BETA_REV}/${P}${BETA_REV}.tar.gz"
S="${WORKDIR}/${P}${BETA_REV}"
LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 ~ppc x86 ~x86-fbsd"
IUSE=""

DEPEND=">=dev-python/twisted-10.1
	>=net-zope/zope-interface-3.6
	dev-python/starpy
	dev-php/PEAR-HTTP
	www-servers/apache"
RDEPEND="${DEPEND}"

#src_compile() {
#Do nothing
#}

src_install() {
	insinto /opt/monast/bin
	doins -r pymon/.
	dosym /opt/monast/bin/monast.py /usr/bin/monast
	insinto /opt/monast/html
	doins -r *.php css image template lib
	insinto /etc
	doins -r pymon/monast.conf.sample
	insinto /etc/init.d
	mv contrib/init.d/rc.gentoo.monast contrib/init.d/monast
	doins -r contrib/init.d/monast
	fperms 755 /etc/init.d/monast
}
