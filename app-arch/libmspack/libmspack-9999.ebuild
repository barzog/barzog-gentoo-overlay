EAPI=4
inherit eutils autotools subversion
DESCRIPTION="The purpose of libmspack is to provide both compression and decompression of some loosely related file formats used by Microsoft."
HOMEPAGE="http://www.cabextract.org.uk/libmspack/"
LICENSE="LGPL-2"
ESVN_REPO_URI="svn://svn.code.sf.net/p/libmspack/code/libmspack/trunk"
SLOT="0"
KEYWORDS="~x86 ~amd64"
#S="${WORKDIR}/${P}/${PN}/trunk"

src_prepare() {
	eautoreconf
}

src_compile() {
	emake
}