# Copyright 2026 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="A simple static blog generator with convenient editor (binary)"
HOMEPAGE="https://github.com/madf/blog-engine"

SRC_URI="https://github.com/madf/blog-engine/releases/download/v${PV}/mbe-linux-x86_64-v${PV}.tar.gz"

LICENSE="BSD"
KEYWORDS="~amd64"
IUSE="vhosts"
SLOT="0"

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
	dobin mbe

	insinto /usr/share/mbe
	doins -r static/*

	insinto /etc/mbe
	doins dist/config.ini

	keepdir /var/lib/mbe
	fowners mbe:mbe /var/lib/mbe
	fperms 0750 /var/lib/mbe

	newinitd "${FILESDIR}"/mbe.initd mbe
	newconfd "${FILESDIR}"/mbe.confd mbe
}
