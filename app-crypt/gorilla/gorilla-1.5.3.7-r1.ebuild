# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit eutils gnome2-utils

DESCRIPTION="Password Safe in secure way with GUI interface"
HOMEPAGE="https://github.com/zdia/gorilla/wiki"
SRC_URI="https://github.com/zdia/gorilla/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-2 BSD"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="
	>=dev-lang/tcl-8.5:*
	>=dev-lang/tk-8.5:*
	dev-tcltk/iwidgets
	dev-tcltk/bwidget"
RDEPEND=${DEPEND}

src_prepare() {
	eapply_user
	sed -i 's:tclsh8.5:tclsh:' sources/gorilla.tcl || die 'Shebang fix sed failed'
}

src_configure() { :; }
src_compile() { :; }

src_install() {
	PREFIX="/opt/${P}"

	insinto ${PREFIX}
	dodoc README sources/CHANGES.txt sources/LICENSE.txt sources/README.how-to-compile-extension.txt sources/README.install-from-source sources/README.translators sources/downloads.txt
	doins -r sources/msgs sources/pwsafe sources/twofish sources/blowfish sources/isaac.tcl sources/modules sources/pics sources/tcllib  sources/viewhelp.tcl sources/help.txt
	newicon -s 16 ${PREFIX}/pics/gorilla-16x16.gif gorilla.gif
	newicon -s 32 ${PREFIX}/pics/gorilla-32x32.gif gorilla.gif
	newicon -s 48 ${PREFIX}/pics/gorilla-48x48.gif gorilla.gif
	newicon -s scalable ${PREFIX}/pics/vector-logo/gorilla-logo.svg gorilla.svg
	exeinto ${PREFIX}
	doexe sources/gorilla.tcl
	make_desktop_entry "${PREFIX}/gorilla.tcl" "Gorilla" "${PN}" "Security;Utility;"
}
pkg_preinst() {
	gnome2_icon_savelist
}

pkg_postinst() {
	gnome2_icon_cache_update

}

pkg_postrm() {
	gnome2_icon_cache_update
}
