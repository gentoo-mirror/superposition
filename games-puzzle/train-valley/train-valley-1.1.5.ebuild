# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit unpacker eutils gnome2-utils

DESCRIPTION="Build railways, manage traffic and stay accident-free."
HOMEPAGE="https://store.steampowered.com/app/353640/Train_Valley/?q=train-valley"
SRC_URI="tv-1.1.5-linux.zip"

LICENSE="all-rights-reserved"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""
RESTRICT="bindist fetch"

MYGAMEDIR=/opt/${PN}
DEPEND="app-arch/unzip"
RDEPEND="${DEPEND}
	dev-libs/expat
	dev-libs/libbsd
	media-libs/mesa
	sys-libs/zlib
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
	local arch=x86
	use amd64 && arch=x86_64

	insinto ${MYGAMEDIR}
	exeinto ${MYGAMEDIR}
	newexe  "linux-universal/${PN}.${arch}" "${PN}"
	doins -r  "linux-universal/${PN}_Data"

	newicon -s 128 linux-universal/${PN}_Data/Resources/UnityPlayer.png ${PN}.png
	make_wrapper ${PN} "${MYGAMEDIR}/${PN}" "${MYGAMEDIR}"
	make_desktop_entry "${PN}" "Train Valley" "${PN}" "Game"

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
