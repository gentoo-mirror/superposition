# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit unpacker eutils

DESCRIPTION="Survive the harsh life of being stuck on a raft in the middle of the ocean!"
HOMEPAGE="https://raft.itch.io/raft"
SRC_URI="V${PVR}_${PN}_LinuxUniversal.zip"

LICENSE="all-rights-reserved"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""
RESTRICT="bindist fetch"

MYGAMEDIR=/opt/${PN}
DEPEND="app-arch/unzip"
RDEPEND="${DEPEND}"
S="${WORKDIR}"

pkg_nofetch() {
	einfo "Please buy & download ${SRC_URI} from:"
	einfo "  ${HOMEPAGE}"
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
	doexe  "V1.04_Raft_LinuxUniversal/V1.04_Raft_LinuxUniversal.x86_64"
	newicon -s 128 "V1.04_Raft_LinuxUniversal/V1.04_Raft_LinuxUniversal_Data/Resources/UnityPlayer.png" "${PN}.png"

	doins -r "V1.04_Raft_LinuxUniversal/V1.04_Raft_LinuxUniversal_Data"
	make_wrapper ${PN} "./V1.04_Raft_LinuxUniversal.x86_64" "${MYGAMEDIR}"
	make_desktop_entry "${PN}" "Raft" "${PN}" "Game"

	domenu ${PN}

}
