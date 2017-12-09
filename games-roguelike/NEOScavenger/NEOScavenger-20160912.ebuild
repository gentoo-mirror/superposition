# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit multilib eutils

DESCRIPTION="survive in the wasteland long enough to figure out who you are"
HOMEPAGE="http://bluebottlegames.com/main/node/2"
SRC_URI="NEOScavenger.tar.gz"

LICENSE="all-rights-reserved"
SLOT="0"
KEYWORDS="-* ~amd64 ~x86"
RESTRICT="fetch mirror"
IUSE="+multilib"

DEPEND=""
RDEPEND="${DEPEND}
	multilib? (
		dev-libs/atk[abi_x86_32]
		dev-libs/glib:2[abi_x86_32]
		dev-libs/nspr[abi_x86_32]
		dev-libs/nss[abi_x86_32]
		media-libs/fontconfig:1.0[abi_x86_32]
		media-libs/freetype:2[abi_x86_32]
		x11-libs/cairo[abi_x86_32]
		x11-libs/gdk-pixbuf:2[abi_x86_32]
		x11-libs/gtk+:2[abi_x86_32]
		x11-libs/libX11[abi_x86_32]
		x11-libs/libXcursor[abi_x86_32]
		x11-libs/libXext[abi_x86_32]
		x11-libs/libXrender[abi_x86_32]
		x11-libs/libXt[abi_x86_32]
		x11-libs/pango[abi_x86_32]
		net-misc/curl[abi_x86_32]
		x11-themes/gtk-engines-adwaita[abi_x86_32]

	)
	!multilib? (
		dev-libs/atk
		dev-libs/glib:2
		dev-libs/nspr
		dev-libs/nss
		media-libs/fontconfig:1.0
		media-libs/freetype:2
		x11-libs/cairo
		x11-libs/gdk-pixbuf:2
		x11-libs/gtk+:2
		x11-libs/libX11
		x11-libs/libXcursor
		x11-libs/libXext
		x11-libs/libXrender
		x11-libs/libXt
		x11-libs/pango
		net-misc/curl
		x11-themes/gtk-engines-adwaita

	)"

REQUIRED_USE="amd64? ( multilib )"
S=${WORKDIR}
pkg_nofetch() {
	ewarn
	ewarn "Place ${SRC_URI} to ${DISTDIR}"
	ewarn
}

src_install() {
	local dir="/opt/${PN}"
	dodir "${dir}"
	insinto "${dir}"
	exeinto "${dir}"

	doins -r SampleModFolder data img
	doexe "${PN}"
	fperms +x "${dir}/${PN}"
	dodoc _readme.txt

	newicon img/x2_nsLogo.png "${PN}.png"
	make_desktop_entry "${dir}/${PN}" "${PN}" "${PN}" "Game"
	domenu ${PN}

}
