# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI="8"

DISTUTILS_USE_PEP517=poetry
PYTHON_COMPAT=( python3_{10..13} )

inherit distutils-r1

DESCRIPTION="A solver for epistemic logic programs."
HOMEPAGE="https://github.com/potassco/eclingo"
SRC_URI="https://github.com/potassco/eclingo/archive/refs/tags/v${PV}.tar.gz -> ${P}.gh.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND="
	>=sci-mathematics/clingo-5.5[python]
"
BDEPEND="
	dev-python/poetry-core
"

distutils_enable_tests pytest
