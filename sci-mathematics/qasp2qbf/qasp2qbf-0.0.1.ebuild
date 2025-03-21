# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI="8"

COMMIT_ID="59fb6e2653a6d678fdf148720274c37909ef9adf"

DISTUTILS_USE_PEP517=setuptools
PYTHON_COMPAT=( python3_{10..13} )

inherit distutils-r1

DESCRIPTION="A translator from quantified ASP to quantified boolean formula."
HOMEPAGE="https://github.com/potassco/qasp2qbf"
SRC_URI="https://github.com/potassco/qasp2qbf/archive/${COMMIT_ID}.tar.gz -> ${P}.tar.gz"

S="${WORKDIR}/${PN}-${COMMIT_ID}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND="
	sci-mathematics/clingo
"

PATCHES="
	${FILESDIR}/0001-remove-dot-py.patch
"

src_prepare() {
	default

	cp "${FILESDIR}/pyproject-0.0.1.toml" "${S}/pyproject.toml"
	cp "${FILESDIR}/__main__.py" "${S}/${PN}/"
}
