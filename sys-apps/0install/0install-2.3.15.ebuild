# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI="7"
PYTHON_COMPAT=( python3_{7,8,9,10,11} )
PYTHON_REQ_USE="xml(+)"
inherit xdg-utils distutils-r1

DESCRIPTION="Zeroinstall Injector allows regular users to install software themselves"
HOMEPAGE="http://0install.net/"
SRC_URI="https://github.com/0install/${PN}/releases/download/v${PV}/${P}.tar.bz2"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~sparc ~x86"
RDEPEND="
	$(python_gen_any_dep '
		dev-python/pygobject:3[${PYTHON_USEDEP}]
	')
	app-crypt/gnupg
"

python_check_deps() {
	has_version "dev-python/pygobject:3[${PYTHON_USEDEP}]"
}

python_prepare_all() {
	# Change manpage install path (Bug 207495)
	sed -i 's:man/man1:share/man/man1:' setup.py || die 'Documentation path fix sed failed.'
	distutils-r1_python_prepare_all
}

python_prepare(){
	sed -i 's:def async:def aasync:' zeroinstall/support/async_compat.py || die 'async name sed failed.'
}

python_install_all() {
	distutils-r1_python_install_all

	local BASE_XDG_CONFIG="/etc/xdg/0install.net"
	local BASE_XDG_DATA="/usr/share/0install.net"

	insinto "${BASE_XDG_CONFIG}/injector"
	newins "${FILESDIR}/global.cfg" global

	dodir "${BASE_XDG_DATA}/native_feeds"
}

pkg_postinst() {
	xdg_icon_cache_update
}

pkg_postrm() {
	xdg_icon_cache_update
}
