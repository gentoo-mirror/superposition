# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=3

inherit findlib oasis

DESCRIPTION="OBus is a pure ocaml implementation of DBus"
HOMEPAGE="https://forge.ocamlcore.org/projects/obus/"
SRC_URI="https://forge.ocamlcore.org/frs/download.php/539/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="~amd64"
IUSE="ocamlopt"

RESTRICT="test"

DEPEND="${DEPEND}
>=dev-lang/ocaml-3.12[ocamlopt?]
dev-ml/type-conv
dev-ml/xmlm[ocamlopt?]
>=dev-ml/lwt-2.2[ocamlopt?]"

RDEPEND="${DEPEND}"

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
