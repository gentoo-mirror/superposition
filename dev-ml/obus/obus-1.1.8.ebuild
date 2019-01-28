# Copyright 1999-2019 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=3

inherit findlib oasis

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
>=dev-ml/lwt-2.7[ocamlopt?]
dev-ml/lwt_react[ocamlopt?]
dev-ml/react
dev-ml/type-conv[ocamlopt?]
dev-ml/xmlm"
DEPEND="${COMMEN_DEPEND}
		dev-ml/ocamlbuild[ocamlopt?]
		dev-ml/oasis[ocamlopt?]"
RDEPEND="${COMMEN_DEPEND}"

src_configure() {
	oasis_src_configure
}

# Fix tests
#src_test() {
#	dbus-launch emake -j1 test || die "make test failed"
#}

src_install() {
	findlib_src_install
}
