# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

DESCRIPTION="A small but efficient C++ library for computing hypertree decompositions."
HOMEPAGE="https://github.com/mabseher/htd"
SRC_URI="https://github.com/mabseher/${PN}/archive/refs/tags/${PV%.*}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3+"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"
BDEPEND="
	>=dev-util/cmake-3.18
"

PATCHES="
	${FILESDIR}/fix-libdir.patch
"

S="${S%.*}"

src_configure() {
	local mycmakeargs=(
		-DBUILD_TESTING=OFF
		-DCMAKE_INSTALL_LIBDIR=lib64
	)
	cmake_src_configure
}
