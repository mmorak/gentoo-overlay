# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

DESCRIPTION="A new solver for asp programs with quantifiers over stable models."
HOMEPAGE="https://github.com/kwrx/qasp"
SRC_URI="https://github.com/kwrx/${PN}/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3+"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""
REQUIRED_USE=""

DEPEND="
	>=dev-libs/boost-1.78.0
"
RDEPEND="${DEPEND}"
BDEPEND="
	>=dev-util/cmake-3.18
	>=dev-util/re2c-0.13
"

PATCHES="
	${FILESDIR}/fix-build.patch
"
