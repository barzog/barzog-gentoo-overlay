EAPI=4
inherit toolchain-funcs flag-o-matic
DESCRIPTION="Comet server which handles 1000000+ parallel browser connections."
SRC_URI="http://github.com/DmitryKoterov/${PN}/archive/v${PV}.tar.gz"
LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
DEPEND="dev-libs/libev
		dev-libs/boost"
S="${WORKDIR}/${P}/cpp"

src_compile() {
	cd ${S}
	$(tc-getCXX) -std=gnu++0x -Wno-unused-result -Wfatal-errors -Wall -pthread -lcrypt -lboost_filesystem -lboost_system -lboost_regex -lev ${LDFLAGS} ${CFLAGS} -o ${PN} ${PN}.cpp || die
}

src_install() {
	cd ${S}
	dobin ${PN}
	insinto /etc
	cd ..
	doins dklab_realplexor.conf
	sed -i -e 's:/etc/default/:/etc/conf.d/:' dklab_realplexor.init
	sed -i -e 's:/opt/:/usr/bin/:' dklab_realplexor.init
	sed -i -e 's:/var/run/:/run/:' dklab_realplexor.init
	newinitd dklab_realplexor.init	dklab_realplexor
}
