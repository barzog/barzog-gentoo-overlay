# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-libs/libconfig/libconfig-1.4.8.ebuild,v 1.7 2012/03/18 15:43:26 armin76 Exp $

EAPI="4"

DESCRIPTION="Libconfig is a simple library for manipulating structured configuration files"
HOMEPAGE="http://www.hyperrealm.com/libconfig/libconfig.html"
SRC_URI="http://pkgs.fedoraproject.org/repo/pkgs/${PN}/${P}.tar.gz/094a82afd382aa2305c6cc3c06025c2d/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="1"
KEYWORDS="amd64 ~mips ppc ppc64 sparc x86 ~x86-linux"
IUSE="examples static-libs"

DEPEND="
	sys-devel/libtool
	sys-devel/bison"
RDEPEND=""

src_configure() {
	econf $(use_enable static-libs static)
}

src_test() {
	# It responds to check but that does not work as intended
	emake test
}

src_install() {
	default
	if ! use static-libs; then
		rm -f "${D}"/usr/lib*/lib*.la
	fi
	if use examples; then
		local dir
		for dir in examples/c examples/c++; do
			insinto /usr/share/doc/${PF}/${dir}
			doins ${dir}/*
		done
	fi
}