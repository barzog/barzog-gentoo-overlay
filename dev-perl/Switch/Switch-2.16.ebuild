# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI="0"
inherit perl-module

DESCRIPTION="Switch.pm for newer perl (5.10 and higher)"
AUTHOR="RGARCIA"
HOMEPAGE="http://search.cpan.org/~rgarcia/"
SRC_URI="mirror://cpan/authors/id/${AUTHOR:0:1}/${AUTHOR:0:2}/${AUTHOR}/${P}.tar.gz"

LICENSE="|| ( Artistic GPL-2 )"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~arm ~hppa ~ia64 ~m68k ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc ~x86"
IUSE=""

SRC_TEST="do"

export OPTIMIZE="$CFLAGS"
DEPEND="dev-lang/perl"

src_unpack() {
        perl-module_src_unpack
}

src_install() {
	perl-module_src_install
}
