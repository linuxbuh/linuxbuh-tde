# Copyright 2020 The Trinity Desktop Project
# Distributed under the terms of the GNU General Public License v2

EAPI="7"
TRINITY_MODULE_NAME="tdemultimedia"

inherit trinity-meta-2

DESCRIPTION="TDE sound recorder"
KEYWORDS="~amd64 ~x86"
IUSE="encode mp3 vorbis"

DEPEND="~trinity-base/tdemultimedia-arts-${PV}
	encode? ( mp3? ( media-sound/lame )
			vorbis? ( media-libs/libvorbis ) )"
RDEPEND="${DEPEND}"

TSM_EXTRACT_ALSO="arts oggvorbis_artsplugin"

src_configure() {
	mycmakeargs=(
		-DWITH_LAME="$(usex mp3)"
		-DWITH_VORBIS="$(usex vorbis)"
		-DBUILD_ARTS=yes
	)

	trinity-meta-2_src_configure
}

src_install() {
	trinity-meta-2_src_install

	#Junk all the files that overlap with tdemultimedia-arts.
	#It would be cleaner not to let them install at all, but I wasn't
	#able to pull that off.
	rm -r ${D}/usr/trinity/14/share/apps/artscontrol/
	rm -r ${D}/usr/trinity/14/share/apps/artsbuilder/
	rm -r ${D}/usr/trinity/14/include/
	rm -r ${D}/usr/trinity/14/lib64/libarts*
	rm -r ${D}/usr/trinity/14/lib64/mcop/arts*
	rm -r ${D}/usr/trinity/14/lib64/mcop/Arts/
	rm -r ${D}/usr/trinity/14/share/icons/*/*/apps/artscontrol.png
	rm -r ${D}/usr/trinity/14/share/icons/*/*/apps/artsbuilder.png
	rm -r ${D}/usr/trinity/14/share/icons/hicolor/scalable/
	rm -r ${D}/usr/trinity/14/share/icons/crystalsvg/
	rm -r ${D}/usr/trinity/14/share/applications/tde/artscontrol.desktop
	rm -r ${D}/usr/trinity/14/share/applications/tde/artsbuilder.desktop
	rm -r ${D}/usr/trinity/14/bin/artscontrol
	rm -r ${D}/usr/trinity/14/bin/artsbuilder
	rm -r ${D}/usr/trinity/14/bin/midisend
	rm -r ${D}/usr/trinity/14/share/mimelnk/
	rm -r ${D}/usr/trinity/14/share/apps/kicker/
}
