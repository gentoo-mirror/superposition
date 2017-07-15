# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI="5"
PYTHON_COMPAT=( python2_7 )
DISTUTILS_SINGLE_IMPL=1
PYTHON_REQ_USE="xml(+)"
inherit distutils-r1 eutils

DESCRIPTION="Zeroinstall Injector allows regular users to install software themselves"
HOMEPAGE="http://0install.net/"
SRC_URI="https://sourceforge.net/projects/zero-install/files/${PN}/${PV}/${P}.tar.bz2"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~ppc ~sparc ~x86"

DEPEND=""
RDEPEND=">=dev-python/pygtk-2.0[${PYTHON_USEDEP}]
	app-crypt/gnupg"

python_prepare_all() {
	# Change manpage install path (Bug 207495)
	sed -i 's:man/man1:share/man/man1:' setup.py || die 'Documentation path fix sed failed.'
	cp "${FILESDIR}/0distutils-r2" "${WORKDIR}/0distutils" || die 'Copying 0distutils to work directory failed.'
	python_fix_shebang .
	distutils-r1_python_prepare_all
}

python_install_all() {
	distutils-r1_python_install_all

	exeinto "/usr/sbin/"
	doexe "${WORKDIR}/0distutils"

	domenu share/applications/0install.desktop
	local BASE_XDG_CONFIG="/etc/xdg/0install.net"
	local BASE_XDG_DATA="/usr/share/0install.net"

	insinto "${BASE_XDG_CONFIG}/injector"
	newins "${FILESDIR}/global.cfg" global

	dodir "${BASE_XDG_DATA}/native_feeds"
}
