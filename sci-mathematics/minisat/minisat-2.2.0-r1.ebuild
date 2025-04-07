# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

COMMIT_ID="37dc6c67e2af26379d88ce349eb9c4c6160e8543"

inherit cmake

DESCRIPTION="A minimalistic and high-performance SAT solver."
HOMEPAGE="http://minisat.se/"
SRC_URI="https://github.com/niklasso/minisat/archive/${COMMIT_ID}.tar.gz -> ${P}.gh.tar.gz"

S="${WORKDIR}/${PN}-${COMMIT_ID}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"

BDEPEND="
	dev-build/cmake
"

PATCHES="
	${FILESDIR}/0001-fix-install-dirs.patch
"

src_configure() {
	local mycmakeargs=(
		-DCMAKE_CXX_FLAGS="-fpermissive"
	)
	cmake_src_configure
}
