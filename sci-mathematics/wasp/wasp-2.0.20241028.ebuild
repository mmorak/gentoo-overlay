
# Distributed under the terms of the GNU General Public License v2

EAPI="8"

COMMIT_ID="4dd3dafa2fb3913c367c4b24bab44b535e6abee9"

DESCRIPTION="ASP solver handling disjunctive logic programs under the stable model semantics."
HOMEPAGE="https://github.com/alviano/wasp"
SRC_URI="https://github.com/alviano/wasp/archive/${COMMIT_ID}.tar.gz -> ${P}.tar.gz"

S="${WORKDIR}/${PN}-${COMMIT_ID}"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"

DEPEND="
	>=dev-libs/boost-1.78.0
"
RDEPEND="${DEPEND}"

src_install() {
	dobin build/release/wasp
	dodoc LICENSE README.md
}
