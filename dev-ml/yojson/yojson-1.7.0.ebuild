# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=5

inherit findlib opam

DESCRIPTION="JSON parsing and pretty-printing library for OCaml"
HOMEPAGE="https://github.com/ocaml-community/yojson"
SRC_URI="https://github.com/ocaml-community/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"

SLOT="0/${PV}"
LICENSE="BSD"
KEYWORDS="~amd64"
IUSE="examples"

RDEPEND=">=dev-lang/ocaml-4.02.3:=[ocamlopt]
	dev-ml/easy-format:=[ocamlopt]
	>=dev-ml/biniou-1.2:=[ocamlopt]
"
DEPEND="${RDEPEND}
	dev-ml/cppo
	~dev-ml/dune-1.11.4
"

src_install() {
	opam_src_install

	if use examples ; then
		dodoc -r examples
		docompress -x /usr/share/doc/${PF}/examples
	fi
}
