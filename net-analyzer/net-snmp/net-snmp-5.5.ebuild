# Copyright 1999-2008 Gentoo Foundation ; 2008-2009 Chris Gianelloni
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI="2"

inherit fixheadtails flag-o-matic perl-module python autotools

DESCRIPTION="Software for generating and retrieving SNMP data"
HOMEPAGE="http://net-snmp.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${P}.tar.gz"

LICENSE="as-is BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
# Kernel USE-expand, add Solaris and FreeBSD here when adding support
KERNEL_IUSE="kernel_linux"
IUSE="${KERNEL_IUSE} +bzip2 +diskio doc elf +extensible ipv6 kerberos lm_sensors mfd-rewrites minimal perl python rpm selinux +sendmail +smux ssl tcpd X +zlib"

DEPEND="ssl? ( >=dev-libs/openssl-0.9.6d )
	tcpd? ( >=sys-apps/tcp-wrappers-7.6 )
	rpm? (
		app-arch/rpm
		dev-libs/popt
		app-arch/bzip2
		>=sys-libs/zlib-1.1.4
	)
	elf? ( dev-libs/elfutils )
	kerberos? ( app-crypt/mit-krb5 )
	bzip2? ( app-arch/bzip2 )
	zlib? ( sys-libs/zlib )
	kernel_linux? (
		lm_sensors? (
			=sys-apps/lm_sensors-2*
		)
	)
	python? ( dev-python/setuptools )"
# NOTE: The current net-snmp implementation only works with MIT's libraries

RDEPEND="${DEPEND}
	perl? (
		X? ( dev-perl/perl-tk )
		!minimal? ( dev-perl/TermReadKey )
	)
	selinux? ( sec-policy/selinux-snmpd )"

# Dependency on autoconf due to bug #225893
DEPEND="${DEPEND}
	>=sys-devel/autoconf-2.61-r2
	>=sys-apps/sed-4
	doc? ( app-doc/doxygen )"

pkg_setup() {
	use perl && perlinfo
	use !ssl && ewarn "AES and encryption support disabled. USE=ssl to enable."
}

src_prepare() {
	# fix access violation in make check
	sed -i -e 's/\(snmpd.*\)-Lf/\1-l/' testing/eval_tools.sh || \
		die "sed eval_tools.sh failed"
	# fix path in fixproc
	sed -i -e 's|\(database_file =.*\)/local\(.*\)$|\1\2|' local/fixproc || \
		die "sed fixproc failed"

	if use python ; then
		python_version
		PYTHON_MODNAME="netsnmp"
		PYTHON_DIR=/usr/$(get_libdir)/python${PYVER}/site-packages
		sed -i -e "s:\(install --basedir=\$\$dir\):\1 --root='${D}':" Makefile.in || die "sed python failed"
	fi

	# snmpconf generates config files with proper selinux context
	use selinux && epatch "${FILESDIR}"/${P}-snmpconf-selinux.patch

	# Fix version number:
	sed -i -e "s:NetSnmpVersionInfo = \".*\":NetSnmpVersionInfo = \"${PV}\":" \
		snmplib/snmp_version.c

#	eautoreconf

	ht_fix_all
}

src_configure() {
	local mibs myconf

	strip-flags

	### MIB module creation section
	# ucd-snmp/dlmod and host are both built by default with the full agent
	mibs=""
	# We don't need Rmon for embedded hosts
	use !minimal && mibs="${mibs} Rmon"
	# Additional hardware support
	use diskio && mibs="${mibs} ucd-snmp/diskio"
	use lm_sensors && mibs="${mibs} ucd-snmp/lmSensors"
	# This should really be default, since it's the RFC MTA MIB
	use sendmail && mibs="${mibs} mibII/mta_sendmail"
	# The TUNNEL-MIB only supports Linux and Solaris, but I cannot test Solaris.
	# The SCTP-MIB and EtherLike-MIB only support Linux.
	use kernel_linux && mibs="${mibs} etherlike-mib sctp-mib tunnel"
	# These two extend functionality of the agent's capabilities
	use smux && mibs="${mibs} smux"
	use extensible && mibs="${mibs} ucd-snmp/extensible"

	### Configure creation section
	# These are the common settings
	# TODO:
	# Add dmalloc/efence support
	# Add PKCS#11 support
	# Add support for specifying transports
	# Add support for specifying security modules (usm, ksm, tsm)
	myconf="${myconf} \
		$(use_with elf) \
		$(use_with ssl openssl) \
		$(use_with tcpd libwrap) \
		$(use_enable ipv6) \
		$(use_enable mfd-rewrites) \
		$(use_enable perl embedded-perl) \
		$(use_enable !ssl internal-md5)"
	if use !minimal ; then
		$(use_with perl perl-modules) \
		$(use_with python python-modules)
	fi
	if use kerberos ; then
		myconf="${myconf} \
			--with-krb5"
		# KSM requires LDFLAGS -lkrb5 -lk5crypto -lcom_err, but this isn't
		# working yet and I haven't had time to investigate as it's considered
		# an experimental feature still.
#		append-flags -I/usr/include -lkrb5 -lk5crypto -lcom_err
#		sec_modules="ksm usm"
#	else
#		sec_modules="usm"
	fi
	if use minimal ; then
		myconf="${myconf} \
		--disable-applications \
		--disable-scripts
		--enable-mini-agent"
	fi
	if use rpm ; then
		myconf="${myconf} \
			--with-rpm \
			--with-bzip2 \
			--with-zlib"
	else
		myconf="${myconf} \
			$(use_with bzip2) \
			$(use_with zlib)"
	fi
	# These are answers to the questions asked by configure
	answers="--with-sys-location=Unknown \
		--with-sys-contact=root@Unknown \
		--with-default-snmp-version=3 \
		--with-logfile=/var/log/net-snmpd.log \
		--with-persistent-directory=/var/lib/net-snmp"

#		--with-security-modules="${sec_modules}" \
	econf \
		${answers} \
		--with-install-prefix="${D}" \
		--with-mib-modules="${mibs}" \
		--enable-ucd-snmp-compatibility \
		--enable-shared \
		--enable-as-needed \
		${myconf} \
		|| die "econf failed"
}

src_compile() {
	emake -j1 || die "emake failed"

	if use doc ; then
		einfo "Building HTML Documentation"
		make docsdox || die "failed to build docs"
	fi
}

src_test() {
	cd testing
	if ! make test ; then
		echo
		einfo "Don't be alarmed if a few tests FAIL."
		einfo "This could happen for several reasons:"
		einfo "    - You don't already have a working configuration."
		einfo "    - Your ethernet interface isn't properly configured."
		echo
	fi
}

src_install () {
	make DESTDIR="${D}" install || die "make install failed"

	if use perl ; then
		fixlocalpod
		use X || rm -f "${D}/usr/bin/tkmib"
	else
		rm -f "${D}/usr/bin/mib2c" "${D}/usr/bin/tkmib" "${D}/usr/bin/snmpcheck"
	fi

	dodoc AGENT.txt ChangeLog FAQ INSTALL NEWS PORTING README* TODO
	newdoc EXAMPLE.conf.def EXAMPLE.conf

	use doc && dohtml docs/html/*

	keepdir /etc/snmp /var/lib/net-snmp /var/agentx

	newinitd "${FILESDIR}"/snmpd.rc7 snmpd
	newconfd "${FILESDIR}"/snmpd.conf snmpd

	newinitd "${FILESDIR}"/snmptrapd.rc7 snmptrapd
	newconfd "${FILESDIR}"/snmptrapd.conf snmptrapd

	# Remove everything not required for an agent, keeping only the snmpd,
	# snmptrapd, MIBs, libs, and includes.
	if use minimal; then
		elog "USE=minimal is set. Cleaning up excess cruft for an embedded/minimal/server-only install."
		rm -rf "${D}"/usr/bin/{encode_keychange,snmp{get,getnext,set,usm,walk,bulkwalk,table,trap,bulkget,translate,status,delta,test,df,vacm,netstat,inform,snmpcheck}}
		rm -rf "${D}"/usr/share/snmp/snmpconf-data "${D}"/usr/share/snmp/*.conf
		rm -rf "${D}"/usr/bin/{fixproc,traptoemail} "${D}"/usr/bin/snmpc{heck,onf}
		find "${D}" -name '*.pl' -exec rm -f '{}' \;
		use ipv6 || rm -rf "${D}"/usr/share/snmp/mibs/IPV6*
	fi

	# bug 113788, install example config
	insinto /etc/snmp
	newins "${S}"/EXAMPLE.conf snmpd.conf.example
}

pkg_postrm() {
	use perl && updatepod
	use python && python_mod_cleanup
}

pkg_postinst() {
	use perl && updatepod
	elog "An example configuration file has been installed in"
	elog "/etc/snmp/snmpd.conf.example."
}
