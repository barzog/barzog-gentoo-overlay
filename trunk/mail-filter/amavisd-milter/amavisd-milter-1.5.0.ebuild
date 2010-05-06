EAPI=2

inherit eutils 

DEPEND="net-mail/mailbase
	!!mail-filter/libmilter
	mail-mta/sendmail"
RDEPEND="${DEPEND}"

DESCRIPTION="amavisd-milter is a sendmail milter for amavisd-new version 2.2.0 and above which use the new AM.PDP protocol."
HOMEPAGE="http://amavisd-milter.sourceforge.net"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="GPL-2"

IUSE=""
SLOT="0"
KEYWORDS="~amd64 ~x86"

src_install() {
	emake DESTDIR="${D}" install || die "install failed"
	newinitd "${FILESDIR}"/amavisd-milter.initd amavisd-milter
	newconfd "${FILESDIR}"/amavisd-milter.confd amavisd-milter
	local user="smmsp"
}
