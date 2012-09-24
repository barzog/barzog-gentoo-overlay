# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="3"
USE_RUBY="ruby18"
inherit eutils confutils depend.apache ruby-ng

DESCRIPTION="The Puppet Dashboard is a web interface and reporting tool for your
Puppet installation."
HOMEPAGE="https://github.com/puppetlabs/puppet-dashboard/"
SRC_URI="http://www.puppetlabs.com/downloads/dashboard/${P}.tar.gz"

KEYWORDS="~amd64"
LICENSE="GPL-2"
SLOT="0"
IUSE="fastcgi imagemagick mysql openid passenger postgres sqlite3"

RDEPEND="$(ruby_implementation_depend ruby18 '>=' -1.8.6)[ssl]"

ruby_add_rdepend "
	dev-ruby/rails:2.3
	>=dev-ruby/rubygems-1.3.7
	~dev-ruby/rack-1.1.0
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

pkg_setup() {
	confutils_require_any mysql postgres sqlite3
	enewgroup dashboard
	# home directory is required for SCM.
	enewuser dashboard -1 -1 "${DASHBOARD_DIR}" dashboard
}

all_ruby_prepare() {
	rm -rf vendor/rails || die
	#rm -rf vendor/gems || die
	rm -rf ext || die
	rm -rf log || die
	echo "CONFIG_PROTECT=\"${DASHBOARD_DIR}/config\"" > "${T}/50${PN}"
	echo "CONFIG_PROTECT_MASK=\"${DASHBOARD_DIR}/config/locales ${DASHBOARD_DIR}/config/settings.yml\"" >> "${T}/50${PN}"
}

all_ruby_install() {
	dodoc {CHANGELOG,COPYING,LICENSE,VERSION} || die
	rm .autotest .gems .gitignore CHANGELOG COPYING LICENSE README.markdown README_PACKAGES.markdown RELEASE_NOTES.md || die

	insinto "${DASHBOARD_DIR}"
	doins -r . || die

	keepdir /var/log/${PN} || die
	dosym /var/log/${PN}/ "${DASHBOARD_DIR}/log" || die

	fowners -R dashboard:dashboard \
		"${DASHBOARD_DIR}/config/environment.rb" \
		/var/log/${PN} || die
	# for SCM
	fowners dashboard:dashboard "${DASHBOARD_DIR}" || die

	if use passenger ; then
		has_apache
		insinto "${APACHE_VHOSTS_CONFDIR}"
		doins "${FILESDIR}/10_dashboard_vhost.conf" || die
	else
		newconfd "${FILESDIR}/${PN}.confd" ${PN} || die
		newinitd "${FILESDIR}/${PN}.initd" ${PN} || die
		keepdir /var/run/${PN} || die
		fowners -R dashboard:dashboard /var/run/${PN} || die
		#dosym /var/run/${PN}/ "${DASHBOARD_DIR}/tmp/pids" || die
	fi
	doenvd "${T}/50${PN}" || die
}

pkg_postinst() {
	einfo
	if [ -e "${ROOT}${DASHBOARD_DIR}/config/initializers/session_store.rb" ] ; then
		elog "Execute the following command to upgrade environment:"
		elog
		elog "# emerge --config \"=${CATEGORY}/${PF}\""
		elog
		elog "For upgrade instructions take a look at:"
		elog "http://docs.puppetlabs.com/dashboard/index.html"
	else
		elog "Execute the following command to initlize environment:"
		elog
		elog "# cd ${DASHBOARD_DIR}"
		elog "# cp config/database.yml.example config/database.yml"
		elog "# cp config/settings.yml.example config/settings.yml"
		elog "# \${EDITOR} config/database.yml"
		elog "# \${EDITOR} config/settings.yml"
		elog "# emerge --config \"=${CATEGORY}/${PF}\""
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
		einfo
		einfo "Upgrade database."
		einfo

		einfo "Migrate database."
		RAILS_ENV="${RAILS_ENV}" ${RUBY} -S rake db:migrate || die
		#einfo "Upgrade the plugin migrations."
		#RAILS_ENV="${RAILS_ENV}" ${RUBY} -S rake db:migrate:upgrade_plugin_migrations # || die
		#RAILS_ENV="${RAILS_ENV}" ${RUBY} -S rake db:migrate_plugins || die
		einfo "Clear the cache and the existing sessions."
		${RUBY} -S rake tmp:cache:clear || die
		${RUBY} -S rake tmp:sessions:clear || die
	else
		einfo
		einfo "Initialize database."
		einfo

		einfo "Generate a session store secret."
		${RUBY} -S rake generate_session_store || die
		einfo "Create the database structure."
		RAILS_ENV="${RAILS_ENV}" ${RUBY} -S rake db:migrate || die
		einfo "Insert default configuration data in database."
		RAILS_ENV="${RAILS_ENV}" ${RUBY} -S rake dashboard:load_default_data || die
	fi

	if [ ! -e "${DASHBOARD_DIR}/config/email.yml" ] ; then
		ewarn
		ewarn "Copy ${DASHBOARD_DIR}/config/email.yml.example to ${DASHBOARD_DIR}/config/email.yml and edit this file to adjust your SMTP settings."
		ewarn
	fi
}