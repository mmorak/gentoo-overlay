# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit cmake

DESCRIPTION="ASP planning tools for PDDL."
HOMEPAGE="https://potassco.org/labs/plasp/"
SRC_URI="https://github.com/potassco/plasp/archive/refs/tags/v${PV}.tar.gz -> ${P}.gh.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"

BDEPEND="
	>=dev-build/cmake-3.18
	>=dev-libs/cxxopts-1.2.0
	>=dev-libs/variant-1.1.2
"

PATCHES=(
	"${FILESDIR}/${P}-install.patch"
	"${FILESDIR}/${P}-stdmove.patch"
	"${FILESDIR}/${P}-iostream.patch"
)
