# Copyright 2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit toolchain-funcs

DESCRIPTION="generate random, yet real-looking, personal data"
HOMEPAGE="https://sourceforge.net/projects/rig/ "
SRC_URI="https://sourceforge.net/projects/rig/files/rig/1.11/rig-1.11.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"
BDEPEND=""

PATCHES=(
	"${FILESDIR}/${P}-useDestDirAndImportMemcpy.patch"
)

DOCS=( "README" "Changelog" )

src_compile() {
	sed -i -e "s:g++ :$(tc-getCXX) ${CXXFLAGS} ${LDFLAGS} :" Makefile \
		|| die "sed fix failed. Uh-oh..."
	emake
}

src_install() {
	dodir /usr/bin
	dodir /usr/man
	dodir /usr/share/rig
	dodir /usr/man/man6

	if [[ -f Makefile ]] || [[ -f GNUmakefile ]] || [[ -f makefile ]] ; then
		emake DESTDIR="${D}" install
	fi
	rm -rf "${D}/usr/man"
	doman rig.6
	einstalldocs
}
