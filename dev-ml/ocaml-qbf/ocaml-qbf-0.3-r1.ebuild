# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

COMMIT_ID="25741cbd641a6353c51b31882820bf245f6d1d79"

inherit dune

DESCRIPTION="OCaml bindings to QBF solver(s)."
HOMEPAGE="https://github.com/c-cube/ocaml-qbf"
SRC_URI="https://github.com/c-cube/ocaml-qbf/archive/${COMMIT_ID}.tar.gz -> ${P}.gh.tar.gz"

S="${WORKDIR}/${PN}-${COMMIT_ID}"

LICENSE="BSD-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE="+ocamlopt"

src_install() {
	dune_src_install qbf
}
