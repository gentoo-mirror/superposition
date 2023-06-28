# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit desktop unpacker

DESCRIPTION="A true Non-Euclidean curved space like you've never experienced before!"
HOMEPAGE="https://codeparade.itch.io/hyperbolica"
SRC_URI="Hyperbolica-Linux-x64.zip"

LICENSE="all-rights-reserved"
SLOT="0"
KEYWORDS="~amd64"
RESTRICT="bindist fetch"

DEPEND="app-arch/unzip"
RDEPEND="${DEPEND}
	media-libs/mesa
	sys-libs/glibc:2.2
	x11-libs/gdk-pixbuf:2
	x11-libs/gtk+:2
	x11-libs/libX11
	x11-libs/libXcursor
	x11-libs/libXrandr
"
BDEPEND=""

QA_PREBUILT="opt/${PN}/UnityPlayer.so opt/${PN}/Hyperbolica_Data/Plugins/libsteam_api.so opt/${PN}/GameAssembly.so opt/${PN}/Hyperbolica.x86_64"

pkg_nofetch() {
	einfo ""
	einfo "Please buy and download \"${A}\" from corresponding shop Itch.io"
	einfo "and move/link it to \"${DISTDIR}\""
	einfo "You can get more info on ${HOMEPAGE}"
	einfo ""
}

src_unpack() {
	unpack_zip ${A}
	mv "${PN}" "${S}" || die "mv failed"
}

src_install() {
	local dir="/opt/${PN}"
	insinto "${dir}"
	exeinto "${dir}"

	doins -r .
	doexe Hyperbolica.x86_64 || die "Failed to install executables"

	newicon "Hyperbolica_Data/Resources/UnityPlayer.png" "${PN}.png"
	make_desktop_entry "${dir}/${PN}.x86_64" "Hyperbolica" "${PN}" || die "make_desktop_entry failed"
}
