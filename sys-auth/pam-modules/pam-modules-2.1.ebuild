# Copyright 1999-2008 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header$

inherit pam autotools eutils

DESCRIPTION="PAM module collection (pam_fshadow,pam_regex,pam_umotd,pam_ldaphome,pam_groupmember)"
HOMEPAGE="http://puszcza.gnu.org.ua/software/pam-modules/manual/html_section/index.html"
SRC_URI="ftp://download.gnu.org.ua/release/pam-modules/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="sys-libs/pam"
RDEPEND="${DEPEND}"

src_compile() {
	econf \
		--disable-fshadow \
		--disable-log \
		--disable-groupmember \
		--disable-mysql \
		--disable-pgsql \
		--disable-ldaphome \
		--disable-umotd
	emake
}

src_install() {
	emake install DESTDIR="${D}"
}