# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit gnome2-utils

DESCRIPTION="Zeroinstall Injector allows regular users to install software themselves"
HOMEPAGE="http://0install.net/"
SRC_URI="https://sourceforge.net/projects/zero-install/files/${PN}/${PV}/${P}.tar.bz2"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE="gtk +ocamlopt test"

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
	app-crypt/gnupg
	app-arch/xz-utils"

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
	 gnome2_icon_cache_update()
}

pkg_postrm()
{
	gnome2_icon_cache_update()
}

