
# Distributed under the terms of the GNU General Public License v2

EAPI="8"

COMMIT_ID="b8139446421c350935825b99e979d124d3a215fb"

inherit autotools

DESCRIPTION="Libraries related to ASPTOOLS and some basic utilities."
HOMEPAGE="https://github.com/tomijanhunen/asplib"
SRC_URI="https://github.com/mmorak/asplib/archive/${COMMIT_ID}.tar.gz -> ${P}.gh.tar.gz"

S="${WORKDIR}/${PN}-${COMMIT_ID}"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~amd64 ~x86"

src_prepare() {
	default
	eautoreconf
}
