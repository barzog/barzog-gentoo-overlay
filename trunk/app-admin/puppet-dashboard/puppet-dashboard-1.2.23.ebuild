# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $
# Get from http://git.csc.ncsu.edu/gitweb/?p=gentoo-vnkuznet-overlay.git;a=tree;f=app-admin/puppet-dashboard;hb=HEAD

EAPI="4"
USE_RUBY="ruby18 ruby19"
inherit eutils confutils depend.apache ruby-ng

DESCRIPTION="The Puppet Dashboard is a web interface and reporting tool for your
Puppet installation."
HOMEPAGE="https://github.com/puppetlabs/puppet-dashboard/"
SRC_URI="http://www.puppetlabs.com/downloads/dashboard/${P}.tar.gz"

KEYWORDS="~amd64"
LICENSE="Apache-2.0"
SLOT="0"
IUSE="fastcgi imagemagick mysql openid passenger postgres sqlite3"
REQUIRED_USE="|| ( mysql postgres sqlite3 )"

RDEPEND="$(ruby_implementation_depend ruby18 '>=' -1.8.6)[ssl]"

ruby_add_rdepend "
	dev-ruby/rails:2.3
	>=dev-ruby/rubygems-1.3.7
	dev-ruby/rack
	dev-ruby/rake
	dev-ruby/haml
	dev-ruby/sass
	dev-ruby/maruku
	dev-ruby/mocha
	dev-ruby/rspec:0
	dev-ruby/rspec-rails:0
	dev-ruby/shoulda
	dev-ruby/will_paginate"

ruby_add_rdepend "dev-ruby/activerecord:2.3[mysql?,postgres?,sqlite3?]"
ruby_add_rdepend passenger www-apache/passenger

DASHBOARD_DIR="/var/lib/${PN}"
DASHBOARD_USER="${PN}"
DASHBOARD_GROUP="${PN}"

pkg_setup() {
	enewgroup "${DASHBOARD_GROUP}"
	# home directory is required for SCM.
	enewuser "${DASHBOARD_USER}" -1 -1 "${DASHBOARD_DIR}" "${DASHBOARD_USER}"
}

all_ruby_prepare() {
	rm -rf vendor/rails
	#rm -rf vendor/gems
	rm -rf ext
	rm -rf log
	echo "CONFIG_PROTECT=\"${DASHBOARD_DIR}/config\"" > "${T}/50${PN}"
	echo "CONFIG_PROTECT_MASK=\"${DASHBOARD_DIR}/config/locales ${DASHBOARD_DIR}/config/settings.yml\"" >> "${T}/50${PN}"
}

all_ruby_install() {
	dodoc {CHANGELOG,LICENSE,VERSION,README.markdown,README_PACKAGES.markdown,CONTRIBUTING.md,PLUGINS.md,SELENIUM.md}
	rm .autotest .gems .gitignore CHANGELOG LICENSE README.markdown \
	README_PACKAGES.markdown CONTRIBUTING.md  PLUGINS.md  SELENIUM.md

	insinto "${DASHBOARD_DIR}"
	doins -r .

	keepdir /var/log/"${PN}"
	dosym /var/log/"${PN}"/ "${DASHBOARD_DIR}/log"

	insinto /etc/logrotate.d
	newins "${FILESDIR}/${PN}".logrotate "${PN}"

	fowners "${DASHBOARD_USER}":"${DASHBOARD_GROUP}" "${DASHBOARD_DIR}"
	fowners -R "${DASHBOARD_USER}":"${DASHBOARD_GROUP}" \
		"${DASHBOARD_DIR}"/config/environment.rb \
		/var/log/"${PN}"

	if use passenger ; then
		has_apache
		insinto "${APACHE_VHOSTS_CONFDIR}"
		doins "${FILESDIR}/10_${PN}_vhost.conf"
	else
		newconfd "${FILESDIR}/${PN}.confd" "${PN}"
		newinitd "${FILESDIR}/${PN}.initd" "${PN}"
		keepdir /var/run/"${PN}"
		fowners -R "${DASHBOARD_USER}":"${DASHBOARD_GROUP}" /var/run/"${PN}"
		#dosym /var/run/"${PN}"/ "${DASHBOARD_DIR}/tmp/pids"
	fi

	doenvd "${T}/50${PN}"

}

pkg_postinst() {
	einfo
	if [ -e "${ROOT}${DASHBOARD_DIR}/config/initializers/session_store.rb" ] ; then
		elog "Execute the following command to upgrade environment:"
		elog "		# emerge --config \"=${CATEGORY}/${PF}\""
		elog
		elog "For upgrade instructions take a look at:"
		elog "http://docs.puppetlabs.com/dashboard/index.html"
	else
		elog "Execute the following command to initlize environment:"
		elog "	1. Install a MySQL server if you don't already have one"
		elog "		# cd ${DASHBOARD_DIR}"
		elog "	2. Create an `/etc/puppet-dashboard/database.yml` file."
		elog "		# cp config/database.yml.example config/database.yml"
		elog "		# cp config/settings.yml.example config/settings.yml"
		elog "		# \${EDITOR} config/database.yml"
		elog "		# \${EDITOR} config/settings.yml"
		elog "	3. Apply the database migrations by running the following"
		elog "	   command:"
		elog "		# emerge --config \"=${CATEGORY}/${PF}\""
		elog "	4. Start the Puppet Dashboard server:"
		elog "		# rc-service ${PN} start"
		elog
		elog "Installation notes are at official site:"
		elog "http://docs.puppetlabs.com/dashboard/index.html"
	fi
	einfo
}

pkg_config() {
	if [ ! -e "${DASHBOARD_DIR}/config/database.yml" ] ; then
		eerror "Copy ${DASHBOARD_DIR}/config/database.yml.example to ${DASHBOARD_DIR}/config/database.yml and edit this file in order to configure your database settings for \"production\" environment."
		die
	fi

	local RAILS_ENV=${RAILS_ENV:-production}
	local RUBY=${RUBY:-ruby18}

	cd "${DASHBOARD_DIR}"
	if [ -e "${DASHBOARD_DIR}/config/initializers/session_store.rb" ] ; then
		einfo "Migrate database."
		rake RAILS_ENV="${RAILS_ENV}" db:migrate || die
		einfo "Clear the cache and the existing sessions."
		rake tmp:cache:clear || die
		rake tmp:sessions:clear || die
	else
		einfo
		einfo "Initialize database."
		einfo
		rake RAILS_ENV="${RAILS_ENV}" db:create

		einfo "Generate a session store secret."
		rake generate_session_store || die
		einfo "Create the database structure."
		rake RAILS_ENV="${RAILS_ENV}" db:migrate || die
		einfo "Insert default configuration data in database."
		rake RAILS_ENV="${RAILS_ENV}" dashboard:load_default_data || die
	fi

	if [ ! -e "${DASHBOARD_DIR}/config/email.yml" ] ; then
		ewarn
		ewarn "Copy ${DASHBOARD_DIR}/config/email.yml.example to ${DASHBOARD_DIR}/config/email.yml and edit this file to adjust your SMTP settings."
		ewarn
	fi
}