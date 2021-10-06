# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PYTHON_COMPAT=( python3_{8..10} )

inherit distutils-r1

DESCRIPTION="A solver for epistemic logic programs."
HOMEPAGE="https://github.com/potassco/eclingo"
SRC_URI="https://github.com/potassco/${PN}/archive/refs/tags/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"

DEPEND=""
RDEPEND="
	${DEPEND}
	>=sci-mathematics/clingo-5.0[python]
"
BDEPEND=""

distutils_enable_tests pytest
