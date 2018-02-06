# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit toolchain-funcs user

MY_PV="${PV//_alpha/a}"
MY_PV="${MY_PV//_beta/b}"
MY_PV="${MY_PV//_rc/rc}"
MY_PV="${MY_PV//_p/-P}"
MY_P="${PN}-${MY_PV}"

DESCRIPTION="High-performance production grade DHCPv4 & DHCPv6 server"
HOMEPAGE="http://www.isc.org/kea/"
SRC_URI="ftp://ftp.isc.org/isc/kea/${MY_P}.tar.gz
	ftp://ftp.isc.org/isc/kea/${MY_PV}/${MY_P}.tar.gz"

LICENSE="ISC BSD SSLeay GPL-2" # GPL-2 only for init script
SLOT="0"
KEYWORDS="~amd64"
IUSE="+openssl test"

DEPEND="
	dev-libs/boost:=
	dev-libs/log4cplus
	openssl? ( dev-libs/openssl:= )
	!openssl? ( dev-libs/botan:0= )
	test? ( dev-cpp/gtest )
"

S="${WORKDIR}/${MY_P}"

src_prepare() {
	# Brand the version with Gentoo
	sed -i \
		-e "/VERSION=/s:'$: Gentoo-${PR}':" \
		configure || die
	default
}

src_configure() {
	econf $(use_with openssl) \
			--disable-static
}

src_install() {
	default

	newconfd "${FILESDIR}"/${PN}-confd ${PN}
	newconfd "${FILESDIR}"/${PN}-initd ${PN}

	find "${ED}" \( -name "*.a" -o -name "*.la" \) -delete || die
}

pkg_preinst() {
	enewgroup dhcp
	enewuser dhcp -1 -1 /var/lib/dhcp dhcp
}
