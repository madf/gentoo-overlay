# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit webapp

DESCRIPTION="A simple static blog generator with convenient editor (binary)"
HOMEPAGE="https://github.com/madf/blog-engine"

SRC_URI="https://github.com/madf/blog-engine/releases/download/v${PV}/mbe-linux-x86_64.tar.gz"

LICENSE="BSD"
KEYWORDS="~amd64"
IUSE="vhosts"

DEPEND=""
RDEPEND="${DEPEND}
	sys-libs/zlib
	dev-libs/gmp:0
	app-admin/webapp-config
	acct-user/mbe
	acct-group/mbe
"
BDEPEND=""

S="${WORKDIR}/mbe-linux-x86_64"

QA_PREBUILT="/usr/bin/mbe"
QA_PRESTRIPPED="/usr/bin/mbe"

src_install() {
	webapp_src_preinst

	dobin mbe

	insinto "${MY_HTDOCSDIR}"/static
	doins -r static/*

	insinto /etc/mbe
	newins dist/config.ini config.ini.example

	keepdir /var/lib/mbe
	fowners mbe:mbe /var/lib/mbe
	fperms 0750 /var/lib/mbe

	newinitd "${FILESDIR}"/mbe.initd mbe
	newconfd "${FILESDIR}"/mbe.confd mbe

	webapp_src_install
}

pkg_postinst() {
	webapp_pkg_postinst

	elog "Binary installed to: /usr/bin/mbe"
	elog "Config location: /etc/mbe/"
	elog "Data directory: /var/lib/mbe"
	elog ""
	elog "For webapp-config deployment:"
	elog "  webapp-config -I -h <hostname> -d <directory> mbe mbe"
	elog ""
	elog "This will deploy static files and web server configs."
	elog "The service itself runs system-wide:"
	elog "  rc-service mbe start"
	elog ""
	elog "Edit /etc/mbe/config.ini before starting the service."
}

pkg_prerm() {
	webapp_pkg_prerm
}
