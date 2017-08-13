# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

PYTHON_COMPAT=( python2_7 )
PYTHON_REQ_USE="ssl(+)"

inherit python-single-r1

DESCRIPTION="Client for Freshcode and Freecode-like sites."
HOMEPAGE="http://www.catb.org/~esr/freecode-submit/"
SRC_URI="http://www.catb.org/~esr/freecode-submit/${PF}.tar.gz"

LICENSE="BSD-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="${PYTHON_DEPS}"
RDEPEND="${DEPEND}"

python_prepare_all() {
	sed -i 's:PREFIX=:PREFIX?=:' Makefile || die 'Prefix fix sed failed.'
	python_fix_shebang freecode-submit
	distutils-r1_python_prepare_all
}
