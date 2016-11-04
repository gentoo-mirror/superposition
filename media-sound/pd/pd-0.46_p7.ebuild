# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit autotools eutils

MY_P=${P/_p/-}

DESCRIPTION="real-time music and multimedia environment"
HOMEPAGE="http://msp.ucsd.edu/software.html"
SRC_URI="http://msp.ucsd.edu/Software/${MY_P}.src.tar.gz
	http://puredata.info/Members/hans/pd.png"

LICENSE="|| ( BSD as-is )"
SLOT="0"

#this version is not working with jack => masked
#KEYWORDS="~amd64 ~ppc ~sparc ~x86"

IUSE="alsa debug fftw jack portaudio"
#portmidi is not working

RDEPEND=">=dev-lang/tcl-8.3.3
	>=dev-lang/tk-8.3.3
	alsa? ( >=media-libs/alsa-lib-0.9.0_rc2 )
	jack? ( >=media-sound/jack-audio-connection-kit-0.99.0-r1 )
	fftw? ( >=sci-libs/fftw-3 )
	portaudio? ( media-libs/portaudio )"

#portmidi is not working
#	portmidi? ( media-libs/portmidi )"

DEPEND="${RDEPEND}"

S="${WORKDIR}/${MY_P}"

src_prepare() {
	eautoreconf
}

src_configure() {
	econf $(use_enable alsa) \
		$(use_enable jack) \
		$(use_enable debug) \
		$(use_enable fftw)  \
		$(use_enable portaudio)
#portmidi is not working
#		$(use_enable portmidi)
}

src_compile() {
	emake || die "emake failed."
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed."

	doicon "${DISTDIR}"/${PN}.png
	make_desktop_entry "${PN} -rt" "PureData" "${PN}.ico" "AudioVideo;Audio"
}
