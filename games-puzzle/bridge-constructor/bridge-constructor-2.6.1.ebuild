# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit unpacker

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
RDEPEND="${DEPEND}
	dev-libs/expat
	media-libs/glu
	media-libs/mesa
	sys-libs/zlib
	x11-libs/libX11
	x11-libs/libXau
	x11-libs/libXcursor
	x11-libs/libXdamage
	x11-libs/libXdmcp
	x11-libs/libXext
	x11-libs/libXfixes
	x11-libs/libXrender
	x11-libs/libXxf86vm
	x11-libs/libdrm
	x11-libs/libxcb
	x11-libs/libxshmfence
"
S="${WORKDIR}"

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

pkg_preinst() {
	gnome2_icon_savelist
}

pkg_postinst() {
	gnome2_icon_cache_update

}

pkg_postrm() {
	gnome2_icon_cache_update
}
