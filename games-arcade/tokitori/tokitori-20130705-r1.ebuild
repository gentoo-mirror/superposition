# Copyright 2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI="6"

inherit eutils xdg-utils unpacker-nixstaller

MY_PN="${PN^^t}"
MY_P="${MY_PN}-Linux-${PV:0:4}-${PV:4:2}-${PV:6:2}"

DESCRIPTION="Help a baby chicken save all the eggs."
HOMEPAGE="http://www.tokitori.com/"
SRC_URI="${MY_P}.sh"
RESTRICT="fetch"

LICENSE="all-rights-reserved"
SLOT="0"
KEYWORDS="-* ~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}
	media-libs/libsdl2
	media-libs/openal
	sys-libs/zlib
"

pkg_nofetch() {
	ewarn
	ewarn "Place ${A} to ${DISTDIR}"
	ewarn
}

S="${WORKDIR}"

DOCS=( "README.linux" )

src_unpack() {
	local arch=x86
	use amd64 && arch=x86_64
	nixstaller_unpack "instarchive_all" "instarchive_all_${arch}"
}

src_install() {
	local dir="/opt/${PN}"
	local arch=x86
	use amd64 && arch=x86_64

	exeinto "${dir}"
	insinto "${dir}"

	newexe "${MY_PN}.bin.${arch}" "${PN}"

	newicon "${MY_PN}.png" "${PN}.png"

	make_desktop_entry "${dir}/${PN}" "${MY_PN}" "${PN}"

	doins -r \
		"namespace.txt" \
		"resourcecache.xml" \
		"audio" \
		"config" \
		"cursors" \
		"fx" \
		"animdata" \
		"credits" \
		"ending" \
		"input" \
		"localization" \
		"maps" \
		"menu" \
		"splash" \
		"textures"

	dodoc
}

pkg_postinst() {
	xdg_icon_cache_update
}

pkg_postrm() {
	xdg_icon_cache_update
}
