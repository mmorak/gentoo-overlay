
# Distributed under the terms of the GNU General Public License v2

EAPI="8"

DESCRIPTION="The PicoSAT SAT solver."
HOMEPAGE="https://fmv.jku.at/picosat/"
SRC_URI="https://fmv.jku.at/picosat/picosat-${PV}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"

src_configure() {
	"${S}"/configure.sh --static --shared
}

src_compile() {
	emake -j1
}

src_install() {
	dobin picosat picomcs picomus picogcnf
	dolib.a libpicosat.a
	dolib.so libpicosat.so
	doheader picosat.h
	dodoc LICENSE NEWS README VERSION
}
