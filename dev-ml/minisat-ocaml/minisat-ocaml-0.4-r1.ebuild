# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

COMMIT_ID="9531317c8edd7bc32f9505c06ea3b014333998aa"

inherit findlib

DESCRIPTION="OCaML bindings for the MiniSat satisfiability solver."
HOMEPAGE="https://github.com/abate/minisat-ocaml"
SRC_URI="https://github.com/abate/minisat-ocaml/archive/${COMMIT_ID}.tar.gz -> ${P}.gh.tar.gz"

S="${WORKDIR}/${PN}-${COMMIT_ID}"

LICENSE="LGPL-3-with-linking-exception"
SLOT="0"
KEYWORDS="~amd64"
IUSE="+ocamlopt"

RDEPEND="
	!!dev-ml/ocaml-minisat
"
BDEPEND="
	dev-ml/ocamlbuild
	sci-mathematics/minisat
"

PATCHES="
	${FILESDIR}/0001-fix-compilation.patch
	${FILESDIR}/0002-fix-linking.patch
	${FILESDIR}/0010-fix-lset-usage.patch
"

src_compile() {
	exts=.cma
	if use ocamlopt; then
		exts+=' .cmx .cmxa'
		emake opt
	else
		emake all
	fi
}

src_install() {
	findlib_src_install TARGETS="${exts}"
}
