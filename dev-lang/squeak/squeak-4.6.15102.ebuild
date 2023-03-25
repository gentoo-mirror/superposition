# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=6

DESCRIPTION="Squeak image file"
HOMEPAGE="http://www.squeak.org/"

SRC_URI="
	http://ftp.squeak.org/4.6/Squeak4.6-15102.zip
	http://ftp.squeak.org/4.6/SqueakV46.sources.zip"

LICENSE="Apache-2.0 MIT BitstreamVera"
SLOT="4.6"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="app-arch/unzip
	dev-lang/squeakvm"
RDEPEND=""

S="${WORKDIR}"

src_compile() {
	einfo "Compressing image/changes files."
	gzip "Squeak4.6-15102.image"
	gzip "Squeak4.6-15102.changes"
	gzip "SqueakV46.sources"
	einfo "done."
}

src_install() {
	einfo 'Installing Image/Sources/Changes files.'
	#dodoc ReadMe.txt
	insinto "/usr/lib/squeak"
	# install full image and changes file.
	doins "Squeak4.6-15102.image.gz"
	doins "Squeak4.6-15102.changes.gz"
	# install sources
	doins "SqueakV46.sources.gz"
}

pkg_postinst() {
	elog "Squeak ${PV} image, changes and sources files installed in /usr/lib/squeak"
}
