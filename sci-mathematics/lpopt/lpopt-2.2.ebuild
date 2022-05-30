# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit autotools

DESCRIPTION="A Rule Decomposition Tool for Answer Set Programming"
HOMEPAGE="https://www.dbai.tuwien.ac.at/proj/lpopt/"
SRC_URI="https://www.dbai.tuwien.ac.at/proj/lpopt/${P}-sources.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3+"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"
BDEPEND="
	>=sys-devel/bison-3.0
"

PATCHES="
	${FILESDIR}/fix-compilation.patch
	${FILESDIR}/fix-parallel-make.patch
"

src_prepare() {
	default
	eautoreconf
}
