
# Distributed under the terms of the GNU General Public License v2

EAPI="8"

COMMIT_ID="fa66009b1994a26fd65cd2e9a07a5d7d478d176f"

inherit autotools

DESCRIPTION="Various tools and utilities for answer set programming (ASP)."
HOMEPAGE="https://github.com/tomijanhunen/asptools"
SRC_URI="https://github.com/mmorak/asptools/archive/${COMMIT_ID}.tar.gz -> ${P}.gh.tar.gz"

S="${WORKDIR}/${PN}-${COMMIT_ID}"

LICENSE="GPL-3+"
SLOT="0"
KEYWORDS="~amd64 ~x86"

DEPEND="
	sci-mathematics/asplib
"
RDEPEND="${DEPEND}"

src_prepare() {
	default
	eautoreconf
}
