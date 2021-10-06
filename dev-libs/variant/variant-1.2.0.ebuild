# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DESCRIPTION="A header-only alternative to boost::variant for C++11 and C++14."
HOMEPAGE="https://github.com/mapbox/variant"
SRC_URI="https://github.com/mapbox/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"

DEPEND=""
RDEPEND="${DEPEND}"
BDEPEND=""

# no compilation needed, header-only
src_compile() { :; }

src_install() {
	insinto /usr/include/mapbox
	doins "${S}"/include/mapbox/*.hpp
}
