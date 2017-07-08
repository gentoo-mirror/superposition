# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5

inherit eutils

DESCRIPTION="Password Safe in secure way with GUI interface"
HOMEPAGE="https://github.com/zdia/gorilla/wiki"
SRC_URI="https://github.com/zdia/gorilla/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

DEPEND="
	>=dev-lang/tcl-8.5
	>=dev-lang/tk-8.5
	dev-tcltk/iwidgets
	dev-tcltk/bwidget"
RDEPEND=${DEPEND}

src_prepare() {
	sed -i 's:tclsh8.5:tclsh:' sources/gorilla.tcl || die 'Shebang fix sed failed'
}

src_configure() { :; }
src_compile() { :; }

src_install() {
	PREFIX="/opt/${P}"

	insinto ${PREFIX}
	doins -r sources/itcl3.4  sources/msgs  sources/pwsafe  sources/twofish sources/blowfish sources/gorilla.tcl sources/isaac.tcl sources/modules sources/pics  sources/tcllib  sources/viewhelp.tcl

	make_desktop_entry "${PREFIX}/gorilla.txl"
	domenu gorilla.desktop
}
