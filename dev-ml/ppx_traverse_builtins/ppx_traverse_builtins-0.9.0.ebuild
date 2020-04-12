# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit opam

DESCRIPTION="Builtins for ppx_traverse"
HOMEPAGE="https://github.com/janestreet/ppx_traverse_builtins"
SRC_URI="https://github.com/janestreet/ppx_traverse_builtins/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0/${PV}"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=""
RDEPEND="${DEPEND}"
DEPEND="${RDEPEND}
	~dev-ml/dune-1.11.4"
