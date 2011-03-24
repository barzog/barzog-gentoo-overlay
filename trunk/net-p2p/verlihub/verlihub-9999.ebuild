# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

DESCRIPTION="VerliHub is a Direct Connect protocol server (Hub)"
HOMEPAGE="http://www.verlihub-project.org"
EGIT_PROJECT="verlihub"
EGIT_REPO_URI="git://verlihub.git.sourceforge.net/gitroot/verlihub/verlihub"

inherit git

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~amd64-fbsd ~x86 ~x86-fbsd"

DEPEND="dev-libs/libpcre
	dev-libs/geoip
	>=dev-db/mysql-5.0
	sys-libs/zlib"

src_compile() {
	./configure --prefix=/usr || die "Config failed; please report problems or bugs to http://forums.verlihub-project.org/viewforum.php?f=36"
	emake || die "Make failed; please report problems or bugs to http://forums.verlihub-project.org/viewforum.php?f=36"
}

src_install() {
	make DESTDIR="${D}" install || die

	docinto "scripts"
	dodoc \
		scripts/vh_runhub.in

	docinto ""
	dodoc \
		AUTHORS \
		COPYING \
		ChangeLog \
		INSTALL \
		TODO
}

pkg_postinst() {
	echo
		einfo "You are now ready to use Verlihub into your system."
		einfo "Do NOT report bugs to Gentoo's bugzilla"
		einfo "Please report all bugs to Verlihub forums at http://forums.verlihubproject.org/viewforum.php?f=36"
		einfo
		einfo "Verlihub Project Team"
		einfo
	if [[ -f "/etc/verlihub/dbconfig" ]]
	then
		ewarn "Verlihub is already configured in /etc/verlihub"
		ewarn "You can configure a new hub by typing:"
		ewarn
		ewarn "emerge --config =${CATEGORY}/${PF}"
	else
		ewarn "You MUST configure verlihub before starting it:"
		ewarn
		ewarn "emerge --config =${CATEGORY}/${PF}"
		ewarn
		ewarn "That way you can [re]configure your verlihub setup"
	fi
}

pkg_config() {
	ewarn "Configuring verlihub..."
	/usr/bin/vh_install
	if [[ $? ]]
	then
		einfo "You have not configured verlihub succesfully. Please try again"
	else
		ewarn "Configuration completed"
	fi
}
