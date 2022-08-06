# Copyright 2020 The Trinity Desktop Project
# Distributed under the terms of the GNU General Public License v2

EAPI="7"
TRINITY_MODULE_NAME="tdemultimedia"

inherit cmake

DESCRIPTION="TDE CD ripper and audio encoder frontend"
SRC_URI="http://www.mirrorservice.org/sites/trinitydesktop.org/trinity/releases/R${PV}/main/core/tdemultimedia-trinity-${PV}.tar.xz"
KEYWORDS="~amd64 ~x86"
IUSE="encode flac mp3 vorbis"
DEPEND="~trinity-base/libkcddb-${PV}
	media-sound/cdparanoia"
SLOT=0

# External encoders used - no optional compile-time support
RDEPEND="${RDEPEND}
	~trinity-base/tdemultimedia-tdeioslaves-${PV}
	encode? ( vorbis? ( media-sound/vorbis-tools )
			flac? ( media-libs/flac )
			mp3? ( media-sound/lame ) )"

TSM_EXTRACT_ALSO="libkcddb/ kscd/"

src_configure() {
	mycmakeargs=(
		-DBUILD_LIBKCDDB=yes
		-DBUILD_KSCD=yes
	)

	trinity-meta-2_src_configure
}

src_install() {
	trinity-meta-2_src_install

	#Junk all the files that overlap with libkcddb and kscd.
	#It would be cleaner not to let them install at all, but I wasn't
	#able to pull that off.
	rm -r ${D}/usr/trinity/14/share/apps/tdeconf_update/kcmcddb-emailsettings.upd
	rm -r ${D}/usr/trinity/14/share/config.kcfg/libkcddb.kcfg
	rm -r ${D}/usr/trinity/14/share/applications/tde/libkcddb.desktop
	rm -r ${D}/usr/trinity/14/include/
	rm -r ${D}/usr/trinity/14/lib64/
	rm -r ${D}/usr/trinity/14/bin/kscd
	rm -r ${D}/usr/trinity/14/bin/workman2cddb.pl
	rm -r ${D}/usr/trinity/14/share/applications/tde/kscd.desktop
	rm -r ${D}/usr/trinity/14/share/icons/hicolor/*/apps/kscd.png
	rm -r ${D}/usr/trinity/14/share/icons/hicolor/128x128
	rm -r ${D}/usr/trinity/14/share/icons/hicolor/48x48
	rm -r ${D}/usr/trinity/14/share/icons/hicolor/64x64
	rm -r ${D}/usr/trinity/14/share/config.kcfg/kscd.kcfg
	rm -r ${D}/usr/trinity/14/share/apps/profiles/
	rm -r ${D}/usr/trinity/14/share/apps/konqueror/servicemenus/audiocd_play.desktop
	rm -r ${D}/usr/trinity/14/share/apps/kscd/
	rm -r ${D}/usr/trinity/14/share/mimelnk/
}
