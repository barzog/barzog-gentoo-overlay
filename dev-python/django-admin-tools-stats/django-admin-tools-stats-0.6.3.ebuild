# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-python/django-social-auth/django-social-auth-0.6.8.ebuild,v 1.1 2012/04/25 18:58:58 tampakrap Exp $

EAPI=5
PYTHON_COMPAT=( python{2_6,2_7,3_4,3_5} )

inherit distutils-r1 python-r1

DESCRIPTION="django application which powers dashboard modules with customer stats and charts"
HOMEPAGE="http://github.com/Star2Billing/django-admin-tools-stats"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"
KEYWORDS="~amd64 ~x86"
IUSE=""

LICENSE="MIT"
SLOT="0"

RDEPEND="dev-python/django-cache-utils
	dev-python/django-admin-tools
	dev-python/django-jsonfield
	dev-python/python-memcached
	dev-python/python-dateutil
	dev-python/django-qsstats-magic
	dev-python/django-chart-tools"
DEPEND="${RDEPEND}
	dev-python/django
	dev-python/setuptools"
