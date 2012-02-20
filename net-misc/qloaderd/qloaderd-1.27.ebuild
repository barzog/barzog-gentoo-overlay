# Copyright 1999-2006 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

DESCRIPTION="Script for parse Asterisk queue_log file and push it into MySQL Database (Part of QueueMetrics package)"
HOMEPAGE="http://queuemetrics.com"
LICENSE="GPL-2"

SRC_URI="http://queuemetrics.com/download/${P}.tar.gz"
SLOT="0"
KEYWORDS="~x86 ~amd64 ~ppc ~ia64"

src_install() {
	dosbin qloader.pl
	newinitd "${FILESDIR}/qloaderd.initd" qloaderd
	newconfd "${FILESDIR}/qloaderd.confd" qloaderd
	insinto /etc/logrotate.d
	newins "${FILESDIR}/qloaderd.logrotate" qloaderd
}
