# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit eutils

DESCRIPTION="A point-and-click adventure about the well intentioned but not-so-brilliant Kelvin, his workplace crush, a crazy scientist, and a hideous time machine that came to ruin everything."
HOMEPAGE="http://www.infamousmachine.com"
SRC_URI="infamousmachine_unix_1_0.sh.zip"

LICENSE="all-rights-reserved"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=">=virtual/jre-1.7:*
        virtual/opengl
        media-libs/openal
		app-arch/p7zip"
RDEPEND="${DEPEND}"

RESTRICT="bindist fetch mirror strip"
S="${WORKDIR}"

pkg_nofetch() {
        einfo "Please download ${SRC_URI}"
        einfo "from your personal page in Humble Bundle site"
        einfo "(http://www.humblebundle.com) and place it in ${DISTDIR}"
}


src_unpack() {
	unpack ${A}
	cd "${S}"
	7zip x infamousmachine_unix_1_0.sh
}

src_prepare() {
    rm infamousmachine_unix_1_0.sh
    rmdir '.install4j\'
}

src_install() {
        local dir="/opt/${P}"

        insinto "${dir}"
        doins InfamousMachine.vmoptions
		doins InfamousMachine.jar
		doins .install4j

        exeinto "${dir}"
        doexe InfamousMachine

        make_wrapper ${PN} ./InfamousMachine "${dir}" "${dir}"
        newicon .install4j/InfamousMachine.png "${PN}"
        make_desktop_entry ${PN} "Kelvin and the Infamous Machine" "${PN}" Game

}


