# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit unpacker eutils

DESCRIPTION="Become an appraised bridge engineer and architect in Bridge Constructor"
HOMEPAGE="http://www.headupgames.com/conpresso/_rubric/index.php?rubric=EN+Games+Bridge-Constructor"
SRC_URI="bridgeconstructor_linux_1390863101.zip"

LICENSE="all-rights-reserved"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""
RESTRICT="bindist fetch"

MYGAMEDIR=/opt/${PN}
DEPEND="app-arch/unzip"
RDEPEND="${DEPEND}"

pkg_nofetch() {
	einfo "Please buy & download ${SRC_URI} from:"
	einfo "  https://www.humblebundle.com/store"
	einfo "and move it to ${DISTDIR}"
}

src_unpack() {
	unpack_zip ${A}
}

src_configure() { :; }
src_compile() { :; }

src_install() {
	insinto ${MYGAMEDIR}
	exeinto ${MYGAMEDIR}
	doexe  "BridgeConstructor.x86"
	doins -r  BridgeConstructor_Data

	newicon -s 128 BridgeConstructor_Data/ScreenSelector.png ${PN}.png
	make_wrapper ${PN} "./BridgeConstructor.x86" "${MYGAMEDIR}"
	make_desktop_entry "${PN}" "Bridge Constructor" "${PN}" "Game"

	domenu ${PN}

}
