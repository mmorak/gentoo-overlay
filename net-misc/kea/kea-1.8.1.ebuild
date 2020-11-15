# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit toolchain-funcs

MY_PV="${MY_PV//_p/-P}"
MY_PV="${PV/_/-}"
MY_P="${PN}-${MY_PV}"

DESCRIPTION="High-performance production grade DHCPv4 & DHCPv6 server"
HOMEPAGE="http://www.isc.org/kea/"
if [[ ${PV} == 9999 ]]; then
	inherit autotools git-r3
	EGIT_REPO_URI="https://gitlab.isc.org/isc-projects/${PN}.git"
else
	SRC_URI="https://downloads.isc.org/isc/${PN}/cur/${MY_P}.tar.gz
		https://downloads.isc.org/isc/${PN}/${MY_PV}/${MY_P}.tar.gz"
	[[ "${PV}" == *_beta* ]] || [[ "${PV}" == *_rc* ]] || \
	KEYWORDS="~amd64 ~x86"
fi

LICENSE="ISC BSD SSLeay GPL-2" # GPL-2 only for init script
SLOT="0"
KEYWORDS="~amd64"
IUSE="doc mysql +openssl perfdhcp postgres test"
RESTRICT="!test? ( test )"

#TODO: add kea-shell support (requires python)

DEPEND="
	dev-libs/boost:=
	>=dev-libs/log4cplus-1.0.3
	mysql? ( dev-db/mysql-connector-c )
	openssl? ( dev-libs/openssl:0= )
	!openssl? ( dev-libs/botan:2= )
	postgres? ( dev-db/postgresql )
	test? ( >=dev-cpp/gtest-1.8 )
"
RDEPEND="${DEPEND}
	acct-group/dhcp
	acct-user/dhcp
"
BDEPEND="
	>=sys-devel/bison-3.0
	sys-devel/flex
	virtual/pkgconfig
	doc? (
		app-doc/doxygen
		dev-python/sphinx
		dev-texlive/texlive-latex
		dev-texlive/texlive-latexextra
	)
"

S="${WORKDIR}/${MY_P}"

src_prepare() {
	default
	[[ ${PV} == 9999 ]] && eautoreconf

	# Brand the version with Gentoo
	sed -i \
		-e "/VERSION=/s:'$: Gentoo-${PR}':" \
		configure || die
}

src_configure() {
	local myeconfargs=(
		--disable-static
		--localstatedir="${EPREFIX}/var"
		--enable-install-configurations
		--enable-generate-parser
		$(use_enable doc generate-docs)
		$(use_with mysql)
		$(use_with openssl)
		$(use_enable perfdhcp)
		$(use_with postgres pgsql)
	)
	econf runstatedir=/run "${myeconfargs[@]}"
}

src_install() {
	default

	newconfd "${FILESDIR}"/${PN}-ctrl-agent-confd ${PN}-ctrl-agent
	newconfd "${FILESDIR}"/${PN}-dhcp4-confd ${PN}-dhcp4
	newconfd "${FILESDIR}"/${PN}-dhcp6-confd ${PN}-dhcp6
	newconfd "${FILESDIR}"/${PN}-dhcp-ddns-confd ${PN}-dhcp-ddns

	newinitd "${FILESDIR}"/${PN}-ctrl-agent-initd ${PN}-ctrl-agent
	newinitd "${FILESDIR}"/${PN}-dhcp4-initd ${PN}-dhcp4
	newinitd "${FILESDIR}"/${PN}-dhcp6-initd ${PN}-dhcp6
	newinitd "${FILESDIR}"/${PN}-dhcp-ddns-initd ${PN}-dhcp-ddns

	keepdir /var/lib/${PN}

	# Delete libtool files, static libraries, and useless folders
	find "${ED}" \( -name "*.a" -o -name "*.la" \) -delete || die
	rm -r \
		"${ED}/run" \
		"${ED}/var/log"

	# change paths of control sockets in default config files
	sed -i "s:/tmp/:/run/${PN}/:g" "${ED}"/etc/${PN}/*.conf || die
}
