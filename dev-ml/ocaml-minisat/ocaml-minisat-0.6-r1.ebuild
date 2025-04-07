# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

COMMIT_ID="aeb77768d3cd03534ea808a7232c8bd2e78ec396"

inherit dune

DESCRIPTION="OCaml bindings to Minisat."
HOMEPAGE="https://github.com/c-cube/ocaml-minisat"
SRC_URI="https://github.com/c-cube/ocaml-minisat/archive/${COMMIT_ID}.tar.gz -> ${P}.gh.tar.gz"

S="${WORKDIR}/${PN}-${COMMIT_ID}"

LICENSE="BSD-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE="+ocamlopt"

RDEPEND="
	!!dev-ml/minisat-ocaml
"

src_install() {
	dune_src_install minisat
}
