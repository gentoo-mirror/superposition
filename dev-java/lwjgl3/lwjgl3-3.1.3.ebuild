# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

JAVA_PKG_IUSE="doc source test"
inherit java-pkg-2 java-ant-2

DESCRIPTION="LWJGL is a Java library that enables cross-platform access to popular native APIs useful in the development of graphics (OpenGL), audio (OpenAL) and parallel computing (OpenCL) applications." 
HOMEPAGE="https://www.lwjgl.org/"
SRC_URI="https://github.com/LWJGL/lwjgl3/archive/3.1.3.tar.gz"

LICENSE="BSD"
SLOT="3.1"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=">=virtual/jdk-1.8"
RDEPEND=">=virtual/jre-1.8"

JAVA_PKG_STRICT=true
JAVA_ANT_REWRITE_CLASSPATH="true"
EANT_ANT_TASKS="compile-templates,generate,compile,compile-native"

