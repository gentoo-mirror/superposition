# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit opam

DESCRIPTION="Standard IO Library for OCaml"
HOMEPAGE="https://github.com/janestreet/stdio"
SRC_URI="https://github.com/janestreet/stdio/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0/${PV}"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND="dev-ml/base:= dev-ml/sexplib:="
DEPEND="${RDEPEND}
	~dev-ml/dune-1.11.4"

src_test() {
	jbuilder runtest || die
}
