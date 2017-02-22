# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/django-social-auth/django-social-auth-0.6.8.ebuild,v 1.1 2012/04/25 18:58:58 tampakrap Exp $

EAPI=5
PYTHON_COMPAT=( python{2_6,2_7,3_3,3_4} )

inherit distutils-r1 python-r1

DESCRIPTION="Automatic caching and invalidation for Django models through the ORM."
HOMEPAGE="http://github.com/jbalogh/django-cache-machine"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"
KEYWORDS="~amd64 ~x86"
IUSE=""

LICENSE="MIT"
SLOT="0"

RDEPEND=""
DEPEND="${RDEPEND}
	dev-python/django
	dev-python/setuptools"
