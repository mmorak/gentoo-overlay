# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI="8"

inherit dune

DESCRIPTION="The SAT and QBF Programming Language Bule."
HOMEPAGE="https://github.com/vale1410/bule"
SRC_URI="https://github.com/vale1410/bule/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz"

S="${S}/src"

LICENSE="BSD-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE="+ocamlopt"

DEPEND="
	dev-ml/ocaml-minisat
	dev-ml/ocaml-qbf
	dev-ml/ocaml-tsort
"
RDEPEND="${DEPEND}
	sci-mathematics/clingo
"
