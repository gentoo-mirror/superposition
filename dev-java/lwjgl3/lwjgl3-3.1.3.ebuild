# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

JAVA_PKG_IUSE="doc source test"
inherit java-pkg-2 java-ant-2

DESCRIPTION="LWJGL is a Java library that enables cross-platform access to popular native API"
HOMEPAGE="https://www.lwjgl.org/"
SRC_URI="https://github.com/LWJGL/lwjgl3/archive/3.1.3.tar.gz"

LICENSE="BSD"
SLOT="3.1"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND=">=virtual/jdk-1.8
		dev-java/kotlin
		dev-java/testng
		dev-java/jcommander
		dev-java/snakeyaml"
RDEPEND=">=virtual/jre-1.8"

JAVA_PKG_STRICT=true
JAVA_ANT_REWRITE_CLASSPATH="true"
EANT_BUILD_TARGET="compile-native"
