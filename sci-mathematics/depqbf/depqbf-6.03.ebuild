
# Distributed under the terms of the GNU General Public License v2

EAPI="8"

DESCRIPTION="DepQBF, a solver for quantified boolean formulae (QBF)."
HOMEPAGE="https://github.com/lonsing/depqbf"
SRC_URI="https://github.com/lonsing/depqbf/archive/refs/tags/version-${PV}.tar.gz -> ${P}.gh.tar.gz"

S="${WORKDIR}/${PN}-version-${PV}"

LICENSE="GPL-3+"
SLOT="0"
KEYWORDS="~amd64 ~x86"

DEPEND="
	sci-mathematics/nenofex
	sci-mathematics/picosat
"
RDEPEND="${DEPEND}"

PATCHES="
	${FILESDIR}/0001-fix-picosat.patch
	${FILESDIR}/0002-fix-nenofex.patch
"

src_install() {
	ln -s libqdpll.so.1.0 libqdpll.so.1
	ln -s libqdpll.so.1 libqdpll.so

	dobin depqbf
	dolib.so libqdpll.so.1.0
	dolib.so libqdpll.so.1
	dolib.so libqdpll.so
	dolib.a libqdpll.a
	dodoc COPYING NEWS README
}
