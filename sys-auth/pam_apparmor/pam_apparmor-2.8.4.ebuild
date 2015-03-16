# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-apps/apparmor/apparmor-2.8.4.ebuild,v 1.1 2014/10/15 15:34:32 kensington Exp $

EAPI=5

inherit eutils toolchain-funcs versionator

DESCRIPTION="PAM library for use with AppArmor application security system"
HOMEPAGE="http://wiki.apparmor.net/index.php/Pam_apparmor"
SRC_URI="http://launchpad.net/apparmor/$(get_version_component_range 1-2)/${PV}/+download/apparmor-${PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE="doc"

DEPEND="sys-apps/apparmor"

S=${WORKDIR}/apparmor-${PV}/changehat/pam_apparmor


