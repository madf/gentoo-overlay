# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

CABAL_FEATURES="lib profile haddock hoogle hscolour test-suite"
CABAL_CORE_LIB_GHC_PV="9.8.4"

inherit haskell-cabal

DESCRIPTION="Library for manipulating FilePaths in a cross platform way."
HOMEPAGE="https://github.com/haskell/filepath"

LICENSE="BSD"
SLOT="0/${PV}"
KEYWORDS="~amd64"

RDEPEND="dev-lang/ghc:="
DEPEND="${RDEPEND}"
BDEPEND="dev-haskell/cabal:=[profile?]"
