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
	>=dev-lang/tcl:0/8.5
	>=dev-lang/tk:0/8.5
	dev-tcltk/iwidgets
	dev-tcltk/bwidget"
RDEPEND=${DEPEND}

src_prepare() {
	epatch "${FILESDIR}"/${PN}-script-destdir.patch
}

src_configure() {
	./configure || die "econf failed"
}
src_compile() { :; }

src_install() {
	PREFIX="/opt/${P}"

	insinto ${PREFIX}
	doins -r gorilla.tcl isaac.tcl twofish sha1 blowfish pwsafe pics

	dobin gorilla
}
