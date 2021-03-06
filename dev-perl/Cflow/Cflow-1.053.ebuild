# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-perl/Cflow/Cflow-1.051-r1.ebuild,v 1.5 2010/12/19 12:42:35 armin76 Exp $

EAPI=5

inherit eutils perl-module

FLOW_TOOLS_VERSION="0.68"

DESCRIPTION="Provides an API for reading and analysing raw flow files"
HOMEPAGE="http://net.doit.wisc.edu/~plonka/Cflow/"
SRC_URI="http://net.doit.wisc.edu/~plonka/${PN}/${P}.tar.gz
		ftp://ftp.eng.oar.net/pub/flow-tools/flow-tools-${FLOW_TOOLS_VERSION}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~ppc ~x86 ~amd64"
IUSE=""

DEPEND="dev-lang/perl"

PDEPEND=">=net-analyzer/flow-tools-${FLOW_TOOLS_VERSION}"
RDEPEND="${DEPEND}"

src_unpack() {
        perl-module_src_unpack
        sed -i "s:../../lib/libft.a:/usr/lib/libft.a:" "${S}/Makefile.PL"
}
