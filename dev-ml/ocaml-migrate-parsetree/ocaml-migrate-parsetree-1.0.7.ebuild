# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit findlib opam

DESCRIPTION="Convert OCaml parsetrees between different major versions"
HOMEPAGE="https://github.com/let-def/ocaml-migrate-parsetree"
SRC_URI="https://github.com/let-def/ocaml-migrate-parsetree/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0/${PV}"
KEYWORDS="~amd64 ~arm ~arm64 ~x86"
IUSE=""

DEPEND="dev-ml/result:="
RDEPEND="${DEPEND}"
DEPEND="${DEPEND}
~dev-ml/dune-1.11.4"
