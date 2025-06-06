# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{10..13} )

inherit cmake python-single-r1

DESCRIPTION="A grounder and solver for logic programs."
HOMEPAGE="https://potassco.org/clingo"
SRC_URI="https://github.com/potassco/clingo/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="+python"
REQUIRED_USE="python? ( ${PYTHON_REQUIRED_USE} )"

RDEPEND="
	${DEPEND}
	python? (
		${PYTHON_DEPS}
		>=dev-python/cffi-1.14
	)
	"
BDEPEND="
	>=dev-build/cmake-3.18
	>=dev-util/re2c-1.1.1
	>=sys-devel/bison-2.5
	python? ( ${PYTHON_DEPS} )
"
src_configure() {
	local mycmakeargs=(
		-DBUILD_SHARED_LIBS=OFF
		-DCLINGO_BUILD_WITH_PYTHON="$(usex python ON OFF)"
	)
	cmake_src_configure
}
