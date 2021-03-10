# Copyright 2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=5

inherit eutils autotools
DESCRIPTION="The intelligent predictive text entry system"
HOMEPAGE="http://presage.sourceforge.net"
SRC_URI="mirror://sourceforge/${PN}/${PV}/${P}.tar.gz"

LICENSE="GPL-2+"
SLOT="0"
KEYWORDS="~amd64 ~arm ~x86"
IUSE="doc examples gtk sqlite test"

RDEPEND="
	examples? ( sys-libs/ncurses )
	gtk? ( x11-libs/gtk+ )
	sqlite? ( dev-db/sqlite )
	app-text/dos2unix
"

DEPEND="${COMMON_DEPEND}
	doc? ( app-doc/doxygen )
	dev-lang/swig
	test? ( dev-util/cppunit )
	sys-apps/help2man
"

src_prepare() {
	epatch "${FILESDIR}/${PN}-0.9.1-automagic.patch"
	eautoreconf
}

src_configure() {

	local myeconfargs=(
		$(use_enable doc documentation)
		$(use_enable examples curses)
		$(use_enable gtk gpresagemate)
		#$(use_enable gtk gprompter)

		$(use_enable sqlite)
		$(use_enable test)
	)
	econf ${myeconfargs} --disable-python --disable-python-binding --disable-gprompter

}
