# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit eutils java-pkg-2

DESCRIPTION="Blaster battles with hordes of rampaging killer robots!"
HOMEPAGE="http://www.puppygames.net/droid-assault"
SRC_URI="DroidAssault-HIB-20151219.tar.gz"

LICENSE="all-rights-reserved"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=">=virtual/jre-1.7:*
	virtual/opengl
	media-libs/openal
	dev-java/gson:2.6
	dev-java/lwjgl"
RDEPEND="${DEPEND}"

RESTRICT="bindist fetch mirror strip"
S="${WORKDIR}/droidassault"

pkg_nofetch() {
	einfo "Please download ${SRC_URI}"
	einfo "from your personal page in Humble Bundle site"
	einfo "(http://www.humblebundle.com) and place it in ${DISTDIR}"
}

JAVA_RM_FILES=(
	gson.jar
	lwjgl.jar
	lwjgl_util.jar
	libjinput-linux.so
	libjinput-linux64.so
	liblwjgl.so
	liblwjgl64.so
	7za_amd64
	7za_i386
	jvm.7z
)
src_prepare() {
	epatch "${FILESDIR}/${PV}-launcher.patch"
	default
}

src_install() {
	local dir="/opt/${P}"

	java-pkg_jarinto "${dir}"
	java-pkg_dojar *.jar

	java-pkg_sointo "${dir}"
	java-pkg_doso libgdx.so libgdx64.so

	exeinto "${dir}"
	doexe droidassault.sh || die "doexe"

	make_wrapper ${PN} ./droidassault.sh "${dir}" "${dir}"
	doicon droidassault.png
	make_desktop_entry ${PN} "Droid Assault" droidassault Game
}
