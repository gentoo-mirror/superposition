# Copyright 1999-2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=6

DESCRIPTION="Squeak image file"
HOMEPAGE="http://www.squeak.org/"

SRC_URI="
	http://ftp.squeak.org/5.0/Squeak5.0-15110.zip
	http://ftp.squeak.org/5.0/SqueakV50.sources.zip"

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
	gzip "Squeak5.0-15133.image"
	gzip "Squeak5.0-15133.changes"
	gzip "SqueakV50.sources"
	einfo "done."
}

src_install() {
	einfo 'Installing Image/Sources/Changes files.'
	#dodoc ReadMe.txt
	insinto "/usr/lib/squeak"
	# install full image and changes file.
	doins "Squeak5.0-15133.image.gz"
	doins "Squeak5.0-15133.changes.gz"
	# install sources
	doins "SqueakV50.sources.gz"
}

pkg_postinst() {
	elog "Squeak ${PV} image, changes and sources files installed in /usr/lib/squeak"
}
