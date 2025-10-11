# Copyright 2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

CABAL_FEATURES="lib profile haddock hoogle hscolour"
CABAL_LIVE_VERSION=1

inherit git-r3 haskell-cabal systemd tmpfiles

DESCRIPTION="A simple static blog generator with convenient editor"
HOMEPAGE="https://github.com/madf/blog-engine"
EGIT_REPO_URI="github.com/madf/blog-engine.git"
EGIT_COMMIT="${PV}"

LICENSE="BSD"
SLOT="0/${PV}"
KEYWORDS="~amd64"

RDEPEND="
	acct-group/mbe
	acct-user/mbe
	dev-haskell/aeson:=[profile?]
	dev-haskell/config-ini:=[profile?]
	dev-haskell/clock:=[profile?]
	dev-haskell/crypton:=[profile?]
	dev-haskell/daemons:=[profile?]
	dev-haskell/directory:=[profile?]
	dev-haskell/fast-logger:=[profile?]
	dev-haskell/filepath:=[profile?]
	dev-haskell/hashable:=[profile?]
	dev-haskell/hsyslog:=[profile?]
	dev-haskell/http-types:=[profile?]
	dev-haskell/jose:=[profile?]
	dev-haskell/lens:=[profile?]
	dev-haskell/lucid:=[profile?]
	dev-haskell/mtl:=[profile?]
	dev-haskell/password:=[profile?]
	dev-haskell/resource-pool:=[profile?]
	dev-haskell/scotty:=[profile?]
	dev-haskell/sqlite-simple:=[profile?]
	dev-haskell/text:=[profile?]
	dev-haskell/time:=[profile?]
	dev-haskell/unix:=[profile?]
	dev-haskell/unliftio-core:=[profile?]
	dev-haskell/wai:=[profile?]
	dev-haskell/wai-cors:=[profile?]
	dev-haskell/wai-extra:=[profile?]
	dev-haskell/wai-middleware-static:=[profile?]
	dev-haskell/warp:=[profile?]
	dev-haskell/xxhash-ffi:=[profile?]
	dev-lang/ghc:="
DEPEND="${RDEPEND}
	>=dev-haskell/cabal-3.4.1.0
"

DOCS=( {README,CHANGELOG,design-considerations}.md )

src_install() {
	default
	haskell-cabal_src_install

	insinto /etc/mbe
	doins dist/config.ini

	keepdir /var/log/mbe
	fowners mbe:mbe /var/log/mbe

	newinitd "${FILESDIR}"/mbe.initd mbe
	newconfd "${FILESDIR}"/mbe.confd mbe
	systemd_dounit "${FILESDIR}"/mbe.service
	newtmpfiles "${FILESDIR}"/mbe.tmpfile config.ini
}

pkg_postinst() {
	haskell-cabal_pkg_postinst

	tmpfiles_process config.ini
}
