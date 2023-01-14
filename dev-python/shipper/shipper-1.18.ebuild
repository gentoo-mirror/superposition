# Copyright 2023 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
PYTHON_COMPAT=( python3_8 python3_9 python3_10)
PYTHON_REQ_USE="ssl(+)"

inherit python-single-r1

DESCRIPTION="Automated shipping of open-source project releases."
HOMEPAGE="http://www.catb.org/~esr/shipper/"
SRC_URI="https://gitlab.com/esr/shipper/-/archive/${PV}/${P}.tar.bz2"

LICENSE="BSD-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="irker lftp twython"
DEPEND="${PYTHON_DEPS}"
RDEPEND="${DEPEND}
	virtual/ssh
	lftp? ( net-ftp/lftp )
	irker? ( net-irc/irker )
	twython? ( dev-python/twython )"
REQUIRED_USE="${PYTHON_REQUIRED_USE}"
