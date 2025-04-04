
# Distributed under the terms of the GNU General Public License v2

EAPI="8"

COMMIT_ID="9f71aa01f11c9564742f60b2331ef46ad7025cfb"

inherit autotools

DESCRIPTION="Various tools and utilities for answer set programming (ASP)."
HOMEPAGE="https://github.com/tomijanhunen/asptranslate"
SRC_URI="https://github.com/mmorak/asptranslate/archive/${COMMIT_ID}.tar.gz -> ${P}.gh.tar.gz"

S="${WORKDIR}/${PN}-${COMMIT_ID}"

LICENSE="GPL-2+"
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
