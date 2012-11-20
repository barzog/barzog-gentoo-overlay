EAPI="2"
DESCRIPTION="OFT-Media VOD Server"
HOMEPAGE="http://oft-media.ru/iptv/"
KEYWORDS="amd64 x86"
LICENSE="proprietary"
RESTRICT="fetch"
SLOT="0"
DEPEND="!>dev-libs/libconfig-1.4"
RDEPEND="${DEPEND}"
SRC_URI="vodServer_1.1.0-r6718-1_all.tgz"


src_install() {
        dobin usr/bin/vodIndexer
	dobin usr/bin/vodServer
        insinto /etc/logrotate.d
        newins etc/logrotate.d/vodServer vodServer
        insinto /etc/vodServer
        newins etc/vodServer/vodServer.conf vodServer.conf
        newins etc/vodServer/vodServer.conf.sample vodServer.conf.sample
        doinitd etc/init.d/vodServer
	dolib usr/lib/libconfig++.so.9
}
