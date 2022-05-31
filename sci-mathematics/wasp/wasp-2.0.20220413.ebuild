
# Distributed under the terms of the GNU General Public License v2

EAPI=8

COMMIT_ID="fe8ee14cb8a9f661c227001a7883b51716f4c3a8"

DESCRIPTION="ASP solver handling disjunctive logic programs under the stable model semantics."
HOMEPAGE="https://github.com/alviano/wasp"
SRC_URI="https://github.com/alviano/wasp/archive/${COMMIT_ID}.tar.gz -> ${P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""
REQUIRED_USE=""

DEPEND="
	>=dev-libs/boost-1.78.0
"
RDEPEND="${DEPEND}"
BDEPEND=""

S="${WORKDIR}/${PN}-${COMMIT_ID}"

src_install() {
	dobin build/release/wasp
	dodoc LICENSE README.md
}
