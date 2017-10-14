# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit eutils java-pkg-2

DESCRIPTION="Defeat the returning Titan horde in a series of epic ground battles."
HOMEPAGE="http://www.puppygames.net/revenge-of-the-titans"
SRC_URI="RevengeOfTheTitans-HIB-201512192.tar.gz"

LICENSE="all-rights-reserved"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND=">=virtual/jre-1.7
	virtual/opengl
	media-libs/openal"

RESTRICT="bindist fetch mirror strip"
S="${WORKDIR}/revenge"

pkg_nofetch() {
	einfo "Please download ${SRC_URI}"
	einfo "from your personal page in Humble Bundle site"
	einfo "(http://www.humblebundle.com) and place it in ${DISTDIR}"
}

java_prepare() {
	JAVA_RM_FILES=(
		gson.jar
		jinput.jar
		lwjgl.jar
		7za_amd64
		7za_i386
		jvm.7z
	)
}

src_install() {
	java-pkg_register-dependency gson jinput lwjgl
	local dir="/opt/${P}"

	java-pkg_jarinto "${dir}"
	java-pkg_dojar *.jar

	java-pkg_sointo "${dir}"
	java-pkg_dosoi libgdx.so libgdx64.so

	exeinto "${dir}"
	doexe revenge.sh || die "doexe"

	lwjgl=java-pkg_getjar dev-java/lwjgl lwjgl.jar
	java-pkg_dolauncher ${PN} \
		--main net.puppygames.applet.Launcher
		--java_args "-Dorg.lwjgl.librarypath="${lwjgl}" -Dorg.lwjgl.util.NoChecks=false  -Djava.net.preferIPv4Stack=true -Dnet.puppygames.applet.Launcher.resources=resources-hib.dat " \
		--pwd ${dir}

	doicon revenge.png
	make_desktop_entry ${PN} "Revenge of the Titans" revenge Game
}
