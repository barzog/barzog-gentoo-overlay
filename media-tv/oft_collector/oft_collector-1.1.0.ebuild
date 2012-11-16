EAPI="2"
DESCRIPTION="OFT-Media Collector"
HOMEPAGE="http://oft-media.ru/iptv/"
KEYWORDS="amd64 x86"
LICENSE="proprietary"
RESTRICT="fetch"
SLOT="0"
DEPEND="sys-libs/zlib
	virtual/mysql
	media-tv/oft_libmucast"
RDEPEND="${DEPEND}"
SRC_URI="collector_1.1.0-r6486-1_all.tgz"

src_install() {
	dobin usr/bin/collector
	insinto /etc/logrotate.d
	newins etc/logrotate.d/collector collector
	insinto /etc/eservices
	newins etc/eservices/collector.conf collector.conf
	newins etc/eservices/collector.conf.sample collector.conf.sample
	doinitd etc/init.d/collector
}
