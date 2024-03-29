# Copyright 2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit gnome2-utils

DESCRIPTION="BYOB (Build Your Own Blocks) is an advanced offshoot of Scratch"
HOMEPAGE="http://snap.berkeley.edu/old-byob.html"
SRC_URI="https://www.dropbox.com/s/cevf5my91pjy0t1/BYOB-Pi.image
http://snap.berkeley.edu/byoblib.tgz
https://dl.dropbox.com/s/6dexo1gzyldapwm/BYOB.png -> byob.png"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="+alsa oss pulseaudio nas +v4l"

DEPEND="dev-lang/squeakvm[scratch] games-kids/scratch
	alsa? ( dev-lang/squeakvm[alsa] )
	oss? ( dev-lang/squeakvm[oss] )
	pulseaudio? ( dev-lang/squeakvm[pulseaudio] )
	nas? ( dev-lang/squeakvm[nas] )
	v4l? ( dev-lang/squeakvm[v4l] )"
RDEPEND="${DEPEND}"

REQUIRED_USE="?? ( alsa oss pulseaudio nas )"

S="${WORKDIR}"

src_prepare() {
	cp "$DISTDIR/BYOB-Pi.image" "${S}"
	cp "$DISTDIR/byob.png" "${S}"
	mv Help/en/allscreens.html Help/en/allscreens-BYOB.html
	rm Help/en/index.html \
     Help/en/ScratchGettingStartedv14.pdf \
     Help/en/ScratchReferenceGuide14.pdf \
     Help/en/images/getting-started-thumb.gif \
     Help/en/images/help-menu.gif \
     Help/en/images/helpscreens-thumb.gif \
     Help/en/images/scratch-interface-1.gif \
     Help/en/images/scratch-logo.gif \
     Help/en/images/support-site.gif \
	 locale/pt.po locale/de.po locale/it.po locale/fr_CA.po locale/ko.po
	eapply_user
}

src_configure(){

if   use alsa;       then squeak_sound_plugin="ALSA"
elif use oss;        then squeak_sound_plugin="OSS"
elif use pulseaudio; then squeak_sound_plugin="pulse"
elif use nas;		 then squeak_sound_plugin="nas"
else                      squeak_sound_plugin="null"
fi

}

src_install() {
	local datadir="/usr/share/scratch"
	local icondir="/usr/share/icons/hicolor"
	dodir "${datadir}"
	cp -r Help locale Media Projects "${D}${datadir}"
	dodoc "BYOB 2.0.pdf" Elements090224.pdf README-BYOB.txt license.txt release.txt BYOBManual.pdf
	dolib BYOB-Pi.image
	dolib BYOB.ini
	doicon "byob.png"

	install_runner
	make_desktop_entry byob BYOB byob "Education;Development" "MimeType=application/x-scratch-project"
}

install_runner() {
	local tmpexe=$(emktemp)
	cat << EOF > "${tmpexe}"
#!/bin/sh
cd
exec \
	"/usr/bin/squeak"                 \\
-vm-sound-${squeak_sound_plugin}      \\
"/usr/$(get_libdir)/BYOB-Pi.image"    \\
"${@}"
EOF
	chmod go+rx "${tmpexe}"
	newbin "${tmpexe}" "${PN}" || die
}

pkg_preinst() {
	gnome2_icon_savelist
}

pkg_postinst() {
	gnome2_icon_cache_update

}

pkg_postrm() {
	gnome2_icon_cache_update
}
