
# Distributed under the terms of the GNU General Public License v2

EAPI="8"

DESCRIPTION="Nenofex, an expansion-based QBF solver for negation normal form."
HOMEPAGE="https://github.com/lonsing/nenofex"
SRC_URI="https://github.com/lonsing/nenofex/archive/refs/tags/version-${PV}.tar.gz -> ${P}.gh.tar.gz"

S="${WORKDIR}/${PN}-version-${PV}"

LICENSE="GPL-3+"
SLOT="0"
KEYWORDS="~amd64 ~x86"

DEPEND="
	sci-mathematics/picosat
"
RDEPEND="${DEPEND}"

PATCHES="
	${FILESDIR}/0001-fix-picosat.patch
"

src_install() {
	ln -s "libnenofex.so.${PV}" libnenofex.so.1
	ln -s libnenofex.so.1 libnenofex.so

	dobin nenofex
	doheader nenofex.h
	dolib.so "libnenofex.so.${PV}"
	dolib.so "libnenofex.so.1"
	dolib.so "libnenofex.so"
	dolib.a libnenofex.a
	dodoc COPYING README
}
