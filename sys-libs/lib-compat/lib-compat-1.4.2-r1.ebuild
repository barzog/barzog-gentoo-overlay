# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-libs/lib-compat/lib-compat-1.4.2.ebuild,v 1.4 2011/03/25 09:45:35 xarthisius Exp $

DESCRIPTION="Compatibility C++ and libc5 and libc6 libraries for programs new and old"
HOMEPAGE="http://www.gentoo.org/"
SRC_URI="mirror://gentoo/${P}.tar.bz2"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha x86 amd64"
IUSE=""
QA_PRESTRIPPED="/usr/lib64/libstdc++.so.2.9
	/usr/lib64/libstdc++.so.2.8
	/usr/lib64/libstdc++.so.2.7.2
	/usr/lib64/libc.so.5
	/usr/lib64/libg++.so.2.7.2"
QA_DT_NEEDED="/usr/lib64/libc.so.5"

S=${WORKDIR}/${P}/${ARCH}
if [ ${ARCH} = 'amd64' ];
then
	S=${WORKDIR}/${P}/x86
fi

src_install() {
	if use x86 ; then
		into /
		dolib.so ld-linux.so.1*
		rm -f ld-linux.so.1*
	fi
	into /usr
	dolib.so *.so*
}
