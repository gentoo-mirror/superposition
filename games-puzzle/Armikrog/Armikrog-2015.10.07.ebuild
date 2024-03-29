# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit unpacker desktop gnome2-utils

DESCRIPTION="Armikrog is a unique stop motion clay animated point and click adventure game"
HOMEPAGE="http://armikrog.com/"
SRC_URI="Armikrog_Linux.x86_64.zip"

LICENSE="all-rights-reserved"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""
RESTRICT="bindist fetch"

MYGAMEDIR=/opt/${PN}
DEPEND="app-arch/unzip"
RDEPEND="${DEPEND}
		dev-libs/expat
		dev-libs/libbsd
		media-libs/glu
		media-libs/mesa
		x11-libs/libX11
		x11-libs/libXau
		x11-libs/libXcursor
		x11-libs/libXdamage
		x11-libs/libXdmcp
		x11-libs/libXext
		x11-libs/libXfixes
		x11-libs/libXrandr
		x11-libs/libXrender
		x11-libs/libXxf86vm
		x11-libs/libdrm
		x11-libs/libxcb
		x11-libs/libxshmfence
"
BDEPEND=""
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
		doexe  "Armikrog.x86_64"
		doins -r  "Armikrog_Data"

		newicon -s 128 Armikrog_Data/Resources/UnityPlayer.png ${PN}.png
		make_desktop_entry "${MYGAMEDIR}/${PN}.x86_64" "Armikrog" "${PN}" "Game"

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
