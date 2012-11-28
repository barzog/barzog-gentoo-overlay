EAPI="2"
DESCRIPTION="OFT-Media Collector"
HOMEPAGE="http://oft-media.ru/iptv/"
KEYWORDS="amd64 x86"
LICENSE="proprietary"
RESTRICT="fetch"
SLOT="0"
DEPEND="=dev-libs/libmemcached-0.40
	dev-libs/libconfig:1"
RDEPEND="${DEPEND}"
SRC_URI="index-sync_1.1.0-r6461-1_all.tgz"

src_install() {
	dobin usr/bin/index-sync
	insinto /etc/logrotate.d
	newins etc/logrotate.d/index-sync index-sync
	insinto /etc/eservices
	newins etc/eservices/index-sync.conf index-sync.conf
	newins etc/eservices/index-sync.conf.sample index-sync.conf.sample
	doinitd etc/init.d/index-sync
}
