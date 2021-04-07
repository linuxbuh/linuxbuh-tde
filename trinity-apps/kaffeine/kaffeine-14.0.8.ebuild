# Copyright 2020 The Trinity Desktop Project
# Distributed under the terms of the GNU General Public License v2

EAPI="7"
TRINITY_MODULE_TYPE="applications"

TRINITY_EXTRAGEAR_PACKAGING="yes"
TRINITY_HANDBOOK="optional"

TRINITY_LANGS="ar bg bn br ca cs da de el es et fi fr ga gl he
	hu it ja ka km lt mk nb nl nn pa pl pt pt_BR ru se sk sr
	sr@Latn sv tg tr uk uz zh_CN zh_TW"

inherit trinity-base-2

DESCRIPTION="Media player for TDE using Xine and GStreamer backends."
KEYWORDS="~amd64 ~x86"
HOMEPAGE="http://trinitydesktop.org/"
LICENSE="|| ( GPL-2 GPL-3 )"

need-trinity

SLOT="${TRINITY_VER}"

IUSE+=" dvb dpms gstreamer vorbis encode xcb xinerama"

# As of April 2020 Kaffeine can be only build with xinerama support.
# If that is fixed, the build option will be optional again.

DEPEND+=" 
	x11-base/xorg-proto
	media-libs/xine-lib
	dev-libs/libcdio
	x11-libs/libXtst
	gstreamer? (
		media-libs/gstreamer
		media-libs/gst-plugins-base[X]
	)
	encode? ( media-sound/lame  )
	vorbis? ( media-libs/libvorbis )
	xcb? ( x11-libs/libxcb )
	xinerama? ( x11-libs/libXinerama )
	dvb? ( virtual/linuxtv-dvb-headers )"
RDEPEND+=" ${DEPEND}"

src_configure() {
	mycmakeargs=(
		-DBUILD_TRANSLATIONS=ON
		-DWITH_XTEST=ON
		-DWITH_DPMS="$(usex dpms)"
		-DWITH_XINERAMA="$(usex xinerama)"
		-DWITH_XCB="$(usex xcb)"
		-DWITH_GSTREAMER="$(usex gstreamer)"
		-DWITH_OGGVORBIS="$(usex vorbis)"
		-DWITH_LAME="$(usex encode)"
		-DWITH_DVB="$(usex dvb)"
	)

	trinity-base-2_src_configure
}
