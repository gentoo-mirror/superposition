# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit unpacker eutils gnome2-utils

DESCRIPTION="Monster Truck Destruction is the best monster truck game! Great physics, real-time destruction and over 60 licensed trucks such as BIGFOOT and USA-1 to race in 28 dirt and snow covered tracks."
HOMEPAGE="https://www.oddgames.com.au/games/monstertruckdestruction"
SRC_URI="monstertruckdestruction_linux.zip"

LICENSE="all-rights-reserved"
SLOT="0"
KEYWORDS="~amd64"
IUSE="bindist fetch"

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
	arch=x86_64

	insinto ${MYGAMEDIR}
	exeinto ${MYGAMEDIR}
	newexe  "Linux/MTD.${arch}" "${PN}"
	doins -r  "Linux/MTD_Data"

	newicon -s 128 Linux/MTD_Data/Resources/UnityPlayer.png ${PN}.png
	make_wrapper ${PN} "${MYGAMEDIR}/${PN}" "${HOME}"
	make_desktop_entry "${PN}" "MTD" "${PN}" "Game"
	

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

