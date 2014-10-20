# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

ESVN_REPO_URI="http://www.streamboard.tv/svn/oscam/trunk"

inherit eutils subversion

DESCRIPTION="OSCam is an Open Source Conditional Access Module software"
HOMEPAGE="http://streamboard.gmc.to:8001/"
SRC_URI=""

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"

PROTOCOL="camd33 camd35 camd35_tcp newcamd cccam gbox radegast serial constcw pandora"
for share in ${PROTOCOL}; do
	IUSE_PROTOCOL+=" protocol_${share}"
done

READER="nagra irdeto conax cryptoworks seca viaccess videoguard dre tongfang bulcrypt"
for card in ${READER}; do
	IUSE_READER+=" reader_${card}"
done

IUSE="${IUSE_PROTOCOL} ${IUSE_READER}
	ac csp debug doc dvb gbox ipv6 irdeto lb lcd monitor pcsc +reader +ssl usb +www"

REQUIRED_USE="
	protocol_camd35_tcp?	( protocol_camd35 )
	reader_nagra?		( reader )
	reader_irdeto?		( reader irdeto )
	reader_conax?		( reader )
	reader_cryptoworks?	( reader )
	reader_seca?		( reader )
	reader_viaccess?	( reader )
	reader_videoguard?	( reader )
	reader_dre?		( reader )
	reader_tongfang?	( reader )
	reader_bulcrypt?	( reader )
"

DEPEND="dev-util/cmake"
RDEPEND="${DEPEND}
	dev-libs/openssl
	usb? ( dev-libs/libusb )
	pcsc? ( sys-apps/pcsc-lite )"

RESTRICT="nomirror"

S="${WORKDIR}/${PN}"

src_defs() {
	myconf=""
	if use ac; then
		myconf="${myconf} CS_ANTICASC"
	fi
	if use lb; then
		myconf="${myconf} WITH_LB"
	fi
	if use monitor; then
		myconf="${myconf} MODULE_MONITOR"
	fi
	if use csp; then
		myconf="${myconf} CS_CACHEEX"
	fi
	if use debug; then
		myconf="${myconf} WITH_DEBUG"
	fi
	if use dvb; then
		myconf="${myconf} HAVE_DVBAPI"
	fi
	if use ipv6; then
		myconf="${myconf} IPV6SUPPORT"
	fi
	if use irdeto; then
		myconf="${myconf} IRDETO_GUESSING"
	fi
	if use lcd; then
		myconf="${myconf} LCDSUPPORT"
	fi
	if use ssl; then
		myconf="${myconf} WITH_SSL"
	fi
	if use www; then
		myconf="${myconf} WEBIF"
	fi
	if use protocol_camd33; then
		myconf="${myconf} MODULE_CAMD33"
	fi
	if use protocol_camd35; then
		myconf="${myconf} MODULE_CAMD35"
	fi
	if use protocol_camd35_tcp; then
		myconf="${myconf} MODULE_CAMD35_TCP"
	fi
	if use protocol_newcamd; then
		myconf="${myconf} MODULE_NEWCAMD"
	fi
	if use protocol_cccam; then
		myconf="${myconf} MODULE_CCCAM"
	fi
	if use protocol_gbox; then
		myconf="${myconf} MODULE_GBOX"
	fi
	if use protocol_radegast; then
		myconf="${myconf} MODULE_RADEGAST"
	fi
	if use protocol_serial; then
		myconf="${myconf} MODULE_SERIAL"
	fi
	if use protocol_constcw; then
		myconf="${myconf} MODULE_CONSTCW"
	fi
	if use protocol_pandora; then
		myconf="${myconf} MODULE_PANDORA"
	fi
	if use reader; then
		myconf="${myconf} WITH_CARDREADER"
	fi
	if use reader_nagra; then
		myconf="${myconf} READER_NAGRA"
	fi
	if use reader_irdeto; then
		myconf="${myconf} READER_IRDETO"
	fi
	if use reader_conax; then
		myconf="${myconf} READER_CONAX"
	fi
	if use reader_cryptoworks; then
		myconf="${myconf} READER_CRYPTOWORKS"
	fi
	if use reader_seca; then
		myconf="${myconf} READER_SECA"
	fi
	if use reader_viaccess; then
		myconf="${myconf} READER_VIACCESS"
	fi
	if use reader_videoguard; then
		myconf="${myconf} READER_VIDEOGUARD"
	fi
	if use reader_dre; then
		myconf="${myconf} READER_DRE"
	fi
	if use reader_tongfang; then
		myconf="${myconf} READER_TONGFANG"
	fi
	if use reader_bulcrypt; then
		myconf="${myconf} READER_BULCRYPT"
	fi

	export myconf
}

src_defs_2() {
	myconf_2=""
	if use usb; then
		myconf="${myconf_2} USE_LIBUSB=1"
	fi
	if use pcsc; then
		myconf="${myconf_2} USE_PCSC=1"
	fi
	export myconf_2
}

src_configure() {
	src_defs
	# Disable everything and enable set options
	./config.sh -D all -E ${myconf}

}

src_compile() {
	emake  ${myconf_2} CC=$(tc-getCC) CXX=$(tc-getCXX) || die "emake failed"
}

src_install() {
	cp Distribution/oscam-1.20-unstable_svn0-x86_64-pc-linux-gnu-ssl oscam || die "cp failed"
	dobin oscam || die "dobin failed"
	dodoc -r Distribution/doc/example/* || die "dodoc failed"

	insinto /etc/oscam/
	doins Distribution/doc/example/*

	newinitd "${FILESDIR}"/oscam.start oscam

	if use doc; then
		doman Distribution/doc/man/* || die "doman failed"
		dodoc -r Distribution/doc/txt/* || die "dodoc failed"
	fi
}

pkg_postinst() {
	einfo "Please reffer to the wiki for assistance with the setup "
	einfo "     located at http://streamboard.gmc.to/wiki/OSCam/en "
}
