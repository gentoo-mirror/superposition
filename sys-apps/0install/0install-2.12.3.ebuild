# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

DESCRIPTION="Zeroinstall Injector allows regular users to install software themselves"
HOMEPAGE="http://0install.net/"
SRC_URI="https://downloads.sf.net/projects/zero-install/${PN}/${PV}/${P}.tar.bz2"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE="gtk +ocamlopt"

DEPEND=">=dev-lang/ocaml-4.02.3[ocamlopt?]
		dev-ml/cppo[ocamlopt?]
		dev-ml/lwt_react[ocamlopt?]
		dev-ml/ocamlbuild[ocamlopt?]
		>=dev-ml/ocurl-0.7.9
		dev-ml/ounit[ocamlopt?]
		>=dev-ml/ocaml-sha-1.9
		dev-ml/xmlm
		dev-ml/yojson
		gtk? ( dev-ml/lablgtk[ocamlopt?]
			   dev-ml/lwt_glib[ocamlopt?] )"
		#dbus? ( obus[ocamlopt?] )"
RDEPEND="${DEPEND}
	app-crypt/gnupg"
