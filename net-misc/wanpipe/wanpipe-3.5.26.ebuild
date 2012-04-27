# Copyright 1999-2007 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit eutils linux-mod toolchain-funcs

DAHDI_RELEASE=2.5.0.2
DAHDI_PV="-r4"

DESCRIPTION="Linux Voice TDM/WAN Router Package"
HOMEPAGE="http://www.sangoma.com/"
SRC_URI="
	ftp://ftp.sangoma.com/linux/current_wanpipe/${P//_beta/}.tgz
	tdm? ( http://downloads.asterisk.org/pub/telephony/dahdi-linux/releases/dahdi-linux-${DAHDI_RELEASE}.tar.gz )
"

LICENSE="WANPIPE"

SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="bitstrm bscstrm bisync sdlc edu pos sdlc mpapi adccp tdm ss7 bri"

RDEPEND="
	sys-libs/ncurses
	=net-misc/dahdi-${DAHDI_RELEASE}${DAHDI_PV}
"
DEPEND="
	sys-devel/flex
	virtual/linux-sources
	${RDEPEND}
"
S="${WORKDIR}/${P//_beta/}"
S_BUILD="${WORKDIR}/build-tmp"
DAHDI_BUILD="${WORKDIR}/dahdi-linux-${DAHDI_RELEASE}"

pkg_setup() {

	linux-mod_pkg_setup
}

src_unpack() {
	unpack ${A}

	# Make a minimal replica of the current system linux kernel headers.
	mkdir -p ${S_BUILD}
	cd ${S_BUILD}
	cp -a ${KV_DIR}/include ${S_BUILD}
	ln -s ${KV_DIR}/Makefile
	ln -s ${KV_DIR}/arch
	ln -s ${KV_DIR}/scripts
#Without this (and Setup patch 3.5.26) kdrvtmp is not compiling
	ln -s ${DAHDI_BUILD}/.version ${DAHDI_BUILD}/include/.version
#Without this string WanCfg is not compiling
	cp -ra ${S}/patches/kdrivers/include/* ${S_BUILD}/include/linux/
	cd ${S}
	epatch ${FILESDIR}/${PN}-3.4.1-zaptel.diff
	epatch ${FILESDIR}/${PN}-3.4.1-wancfg.diff
	epatch ${FILESDIR}/${PN}-3.5.26-setup.diff
}

src_compile() {
	cd ${S}

	PROTOCOLS=""
	use bitstrm && PROTOCOLS="$PROTOCOLS BITSTRM"
	use bscstrm && PROTOCOLS="$PROTOCOLS BSCSTRM"
	use bisync && PROTOCOLS="$PROTOCOLS BISYNC"
	use sdlc && PROTOCOLS="$PROTOCOLS SDLC"
	use edu && PROTOCOLS="$PROTOCOLS EDU"
	use pos && PROTOCOLS="$PROTOCOLS POS"
	use sdlc && PROTOCOLS="$PROTOCOLS SDLC"
	use mpapi && PROTOCOLS="$PROTOCOLS MPAPI"
	use adccp && PROTOCOLS="$PROTOCOLS ADCCP"
	use tdm && PROTOCOLS="$PROTOCOLS TDM"
	use ss7 && PROTOCOLS="$PROTOCOLS SS7"
	use bri && PROTOCOLS="$PROTOCOLS BRI"
	PROTOCOLS="$(sed -re 's/^ //' -e 's/ $//' -e 's/ /,/g' <<< $PROTOCOLS)"

	COMMON_ARGS="--silent --builddir=${S_BUILD} --with-linux=${S_BUILD} --usr-cc=$(tc-getCC) --protocol=${PROTOCOLS} --zaptel-path=${DAHDI_BUILD} --no-zaptel-compile"
	einfo "Building kernel modules ..."
	./Setup drivers ${COMMON_ARGS}

	einfo "Building utilities ..."
	./Setup utility ${COMMON_ARGS}

	einfo "Building config ..."
	./Setup meta ${COMMON_ARGS}
}

src_install() {
	cd ${S}

	# Move kernelmodules and includes to staging dir.
	mv ${S_BUILD}/lib ${D}
	mv ${S_BUILD}/usr ${D}

	# Stage the rest of the files.
	mkdir -p ${D}/dev
	./Setup inst --silent --builddir=${D}

	# Fix wanpipe doc dir name.
	mv ${D}/usr/share/doc/wanpipe ${D}/usr/share/doc/${P}

	newinitd ${FILESDIR}/wanpipe.rc6 wanpipe
}

