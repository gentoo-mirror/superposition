# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit unpacker eutils gnome2-utils

DESCRIPTION="Gnomoria is a sandbox village management game"
HOMEPAGE="http://www.gnomoria.com"
SRC_URI="gnomoria-022316-bin"

LICENSE="all-rights-reserved"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="+system-libs"
RESTRICT="bindist fetch"

MYGAMEDIR=/opt/${PN}
DEPEND="app-arch/unzip"
RDEPEND="${DEPEND}
system-libs? (
	app-arch/p7zip
	dev-lang/mono
	media-libs/libsdl2[sound]
	media-libs/sdl2-image[jpeg,png]
	media-libs/openal
	media-libs/libvorbis
	media-libs/libtheora
)"

S="${WORKDIR}/data"

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
	dodoc Linux.README

	doexe  "Gnomoria.bin.${arch}"
	doins -r  "Content" FNA.dll   FNA.dll.config  "Mod Files"   gnomorialib.dll Gnomoria.exe
	if use system-libs ; then
		if use amd64 ; then
			mv lib64 lib64.orig
			mkdir lib64
			mv lib64.orig/libmojoshader.so lib64
			ln -s /usr/bin/7za lib64/7za
			doins -r lib64
		else
			mv lib lib.orig
			mkdir lib
			mv lib.orig/libmojoshader.so lib
			ln -s /usr/bin/7za lib/7za
			doins -r lib
		fi
	else
		doins -r  Mono.Posix.dll System.Core.dll System.Drawing.dll System.Xml.dll mscorlib.dll Mono.Security.dll System.Configuration.dll System.Data.dll System.Security.dll System.dll mono
		if use amd64 ; then
			doins -r lib64
		else
			doins -r lib
		fi
	fi

	newicon -s 512 Gnomoria.png ${PN}.png
	make_wrapper ${PN} "${MYGAMEDIR}/Gnomoria.bin.${arch}" "${MYGAMEDIR}"
	make_desktop_entry "${PN}" "Gnomoria" "${PN}" "Game"

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
