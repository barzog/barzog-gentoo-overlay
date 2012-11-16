DESCRIPTION="OFT-Media multicast library"
HOMEPAGE="http://oft-media.ru/iptv/"
KEYWORDS="amd64 x86"
LICENSE="proprietary"
RESTRICT="fetch"
SLOT="0"
SRC_URI="libmucast_1.1.0-r309-1_all.tgz"
QA_SONAME="usr/lib64/libmucast.so"

src_install() {
	dolib.so usr/lib/libmucast.so 
}
