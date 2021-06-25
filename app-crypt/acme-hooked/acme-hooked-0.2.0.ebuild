# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

PYTHON_COMPAT=( python{3_7,3_8,3_9,3_10} )
inherit distutils-r1

if [[ ${PV} == 9999 ]]; then
	inherit git-r3
	EGIT_REPO_URI="https://github.com/mmorak/${PN}.git"
else
	SRC_URI="https://github.com/mmorak/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="amd64 x86"
fi

DESCRIPTION="A tiny, auditable script for Let's Encrypt's ACME Protocol"
HOMEPAGE="https://github.com/mmorak/acme-tiny"

LICENSE="MIT"
SLOT="0"
IUSE=""

DEPEND=""
RDEPEND="dev-libs/openssl:0"

python_install_all() {
	# install hook script examples and template
	dodir "/usr/share/${PN}"
	insinto "/usr/share/${PN}"
	doins hooks/template.sh || die
	doins hooks/dns.sh || die
	doins hooks/http.sh || die

	distutils-r1_python_install_all
}
