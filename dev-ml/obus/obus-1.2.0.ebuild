# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DESCRIPTION="OBus is a pure ocaml implementation of DBus"
HOMEPAGE="https://github.com/diml/obus"
SRC_URI="https://github.com/diml/obus/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64"
IUSE="ocamlopt"

RESTRICT="test"

COMMEN_DEPEND="
>=dev-lang/ocaml-4.02.3[ocamlopt?]
>=dev-ml/lwt-2.7.0
dev-ml/lwt_react[ocamlopt?]
dev-ml/react
dev-ml/type-conv[ocamlopt?]
dev-ml/xmlm
dev-ml/ppx_core
dev-ml/ppx_metaquot
dev-ml/menhir
dev-ml/ocaml-migrate-parsetree"
DEPEND="${COMMEN_DEPEND}
		~dev-ml/dune-1.11.4"
RDEPEND="${COMMEN_DEPEND}"

DOCS=( CHANGES.md README.md )

src_test() {
	dbus-launch dune runtest || die "make test failed"
}

src_compile() {
	dune build --profile=release @install || die
}

src_install() {
	dune install --destdir="${D}" || die
	einstalldocs
}
