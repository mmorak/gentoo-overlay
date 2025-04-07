# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit dune

DESCRIPTION="Easy to use and user-friendly topological sort module for OCaml."
HOMEPAGE="https://github.com/dmbaturin/ocaml-tsort"
SRC_URI="https://github.com/dmbaturin/ocaml-tsort/archive/refs/tags/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64"
IUSE="+ocamlopt"

src_install() {
	dune_src_install tsort
}
