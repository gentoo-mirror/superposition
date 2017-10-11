# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

DESCRIPTION="Defeat the returning Titan horde in a series of epic ground battles."
HOMEPAGE="http://www.puppygames.net/revenge-of-the-titans"
SRC_URI="RevengeOfTheTitans-HIB-201512192.tar.gz"

LICENSE="all-rights-reserved"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND=">=virtual/jre-1.6
	virtual/opengl"

RESTRICT="download mirror strip"

pkg_nofetch() {
	einfo "Please download ${SRC_URI}"
	einfo "from your personal page in Humble Indie Bundle #2 site"
	einfo "(http://www.humblebundle.com) and place it in ${DISTDIR}"
}

src_install() {
	local dir="/opt/${P}"
	insinto "${dir}"
	
	doins *.jar || die "doins jar"

	exeinto "${dir}"
	doexe *.so revenge.sh || die "doexe"

	make_wrapper ${PN} ./revenge.sh "${dir}" "${dir}"
	doicon revenge.png
	make_desktop_entry ${PN} "Revenge of the Titans" revenge
}
