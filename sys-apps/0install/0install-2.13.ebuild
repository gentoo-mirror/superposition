# Copyright 1999-2019 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit gnome2-utils

DESCRIPTION="Zeroinstall Injector allows regular users to install software themselves"
HOMEPAGE="http://0install.net/"
SRC_URI="https://sourceforge.net/projects/zero-install/files/${PN}/${PV}/${P}.tar.bz2"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE="gtk +ocamlopt test +dbus"

COMMEN_DEPEND=">=dev-lang/ocaml-4.03.0[ocamlopt?]
		dev-ml/lwt_react[ocamlopt?]
		>=dev-ml/ocurl-0.7.9
		>=dev-ml/ocaml-sha-1.9
		dev-ml/xmlm
		dev-ml/yojson
		gtk? ( >=dev-ml/lablgtk-2.18.2[ocamlopt?]
			   dev-ml/lwt_glib[ocamlopt?] )
		dbus? ( dev-ml/obus[ocamlopt?] )"
DEPEND="${COMMEN_DEPEND}
		dev-ml/cppo[ocamlopt?]
		dev-ml/ocamlbuild[ocamlopt?]
		test? ( dev-ml/ounit[ocamlopt?] )"
RDEPEND="${COMMEN_DEPEND}
		app-crypt/gnupg
		app-arch/xz-utils"

# Disable test phase when test USE flag is disabled
RESTRICT="!test? ( test )"

src_compile() {
	emake -j1 all
}

src_test() {
	emake -j1 test
}

src_install() {
	emake DESTDIR="${D}" install_system
	rm -rf "${D}/usr/share/0install.net"
	einstalldocs
}

pkg_postinst()
{
	 gnome2_icon_cache_update
}

pkg_postrm()
{
	gnome2_icon_cache_update
}
