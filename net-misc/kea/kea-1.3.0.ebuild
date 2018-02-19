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
IUSE="+openssl perfdhcp test"

DEPEND="
	dev-libs/boost:=
	dev-libs/log4cplus
	openssl? ( dev-libs/openssl:= )
	!openssl? ( dev-libs/botan:0= )
	test? ( dev-cpp/gtest )
"

S="${WORKDIR}/${MY_P}"

src_prepare() {
	default

	# Brand the version with Gentoo
	sed -i \
		-e "/VERSION=/s:'$: Gentoo-${PR}':" \
		configure || die
}

src_configure() {
	econf $(use_with openssl) \
		--disable-static
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

	# Delete libtool files and static libraries
	find "${ED}" \( -name "*.a" -o -name "*.la" \) -delete || die

	# We don't want Kea's keactrl utility, since services are managed by initd
	find "${ED}" -name "keactrl*" -delete || die

	# delete perfdhcp if we don't want it
	if ! use perfdhcp; then
		find "${ED}" -name "perfdhcp*" -delete || die
	fi

	# delete useless directories that get installed by 'make install'
	rm -r "${ED}"/var || die

	# rename the hooks directory in $libdir to something easily identifiable
	find "${ED}" -name "hooks" -type d | grep lib \
		| sed -e 'p;s/hooks/kea/' | xargs -n2 mv

	# change paths in default config files
	sed -i 's:/tmp/:/run/kea/:g' "${ED}"/etc/kea/*.conf || die
	sed -i 's|/var/lib/log/.*.log|syslog:daemon|g' \
		"${ED}"/etc/kea/*.conf || die
	sed -i '65i\ \ \ \ \ \ \ \ "name": "/var/db/kea/leases-dhcp4.csv",' \
		"${ED}"/etc/kea/kea-dhcp4.conf || die
	sed -i '57i\ \ \ \ \ \ \ \ "name": "/var/db/kea/leases-dhcp6.csv",' \
		"${ED}"/etc/kea/kea-dhcp6.conf || die
}

pkg_preinst() {
	enewgroup dhcp
	enewuser dhcp -1 -1 /var/lib/dhcp dhcp
}
