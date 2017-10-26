# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

PYTHON_COMPAT=( python2_7 )

inherit eutils autotools python-single-r1
DESCRIPTION="The intelligent predictive text entry system"
HOMEPAGE="http://presage.sourceforge.net"
SRC_URI="mirror://sourceforge/${PN}/${PV}/${P}.tar.gz"

LICENSE="GPL-2+"
SLOT="0"
KEYWORDS="~amd64 ~arm ~x86"
IUSE="doc examples gtk sqlite test"
REQUIRED_USE="${PYTHON_REQUIRED_USE}"

RDEPEND="
	examples? ( sys-libs/ncurses )
	gtk? ( x11-libs/gtk+ )
	${PYTHON_DEPS}
	dev-python/dbus-python[${PYTHON_USEDEP}] 
	sqlite? ( dev-db/sqlite )
	app-text/dos2unix
"

DEPEND="${COMMON_DEPEND}
	doc? ( app-doc/doxygen )
	${PYTHON_DEPS}
	dev-lang/swig
	test? ( dev-util/cppunit )
	sys-apps/help2man
"

src_prepare() {
	epatch "${FILESDIR}/${PN}-0.8.9-automagic.patch"
	eautoreconf
}

src_configure() {

    #   $(use_enable gtk gprompter)

	local myeconfargs=(
		$(use_enable doc documentation)
		$(use_enable examples curses)
        $(use_enable gtk gpresagemate)
		#$(use_enable python)
		#$(use_enable python python-binding)
		$(use_enable sqlite)
		$(use_enable test)
	)
	econf ${myeconfargs} --enable-python --enable-python-binding --disable-gprompter

}
