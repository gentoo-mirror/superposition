# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit unpacker eutils gnome2-utils

DESCRIPTION="Tidalis is a block-based puzzle game"
HOMEPAGE="http://arcengames.com/tidalis/"
SRC_URI="Tidalis_Linux64_v1.5.zip"

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
	arch=x86_64

	insinto ${MYGAMEDIR}
	exeinto ${MYGAMEDIR}
	newexe  "${PN}Linux.${arch}" "${PN}Linux"
	rm -rf "${S}/${PN}Linux_Data/Mono/x86"
	rm -rf "${S}/${PN}Linux_Data/Plugins/x86"
	doins -r  "${PN}Linux_Data"
	chmod 777 RuntimeData/settings.*
	chmod -R 777 RuntimeData/Save
	doins -r RuntimeData
	doins sysrequirements.txt
	dodoc TidalisLicense.txt TidalisManual.pdf

	newicon -s 128 ${PN}Linux_Data/Resources/UnityPlayer.png ${PN}.png
	make_wrapper ${PN} "${MYGAMEDIR}/${PN}Linux" "${MYGAMEDIR}"
	make_desktop_entry "${PN}" "${PN}" "${PN}" "Game"

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
