# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6
PYTHON_COMPAT=( python2_7 python3_3 python3_4 )
PYTHON_REQ_USE="ssl(+)"

inherit python-single-r1

DESCRIPTION="Automated shipping of open-source project releases."
HOMEPAGE="http://www.catb.org/~esr/shipper/"
SRC_URI="http://www.catb.org/~esr/shipper/${PF}.tar.gz"

LICENSE="BSD-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="lftp email scp"
# todo add freecode-submit and irkerd
DEPEND="${PYTHON_DEPS}"
RDEPEND="${DEPEND}
	lftp? ( net-ftp/lftp )
	email? ( || ( mail-mta/sendmail mail-mta/postfix ) )
	scp? ( virtual/ssh )"
REQUIRED_USE="${PYTHON_REQUIRED_USE}"
