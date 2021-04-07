# Copyright 1999-2020 Gentoo Authors
# Copyright 2020 The Trinity Desktop Project
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

TRINITY_EXTRAGEAR_PACKAGING="yes"
TRINITY_HANDBOOK="optional"

TRINITY_LANGS="ar bg bn br ca cs da de el es et fi fr ga gl he
	hu it ja ka km lt mk nb nl nn pa pl pt pt_BR ru se sk sr
	sr@Latn sv tg tr uk uz zh_CN zh_TW"
TRINITY_MODULE_TYPE="applications"
inherit trinity-base-2

DESCRIPTION="Media player for TDE using Xine and GStreamer backends."
HOMEPAGE="https://trinitydesktop.org/"

LICENSE="|| ( GPL-2 GPL-3 )"
SLOT="14"
IUSE="dpms dvb encode gstreamer vorbis xcb xinerama"

# As of April 2020 Kaffeine can be only build with xinerama support.
# Once that is fixed, the build option will be optional again.

RDEPEND="
	dev-libs/libcdio
	media-libs/xine-lib
	x11-base/xorg-proto
	x11-libs/libXtst
	encode? ( media-sound/lame )
	gstreamer? (
		media-libs/gstreamer
		media-libs/gst-plugins-base[X]
	)
	vorbis? ( media-libs/libvorbis )
	xcb? ( x11-libs/libxcb )
	xinerama? ( x11-libs/libXinerama )
"
DEPEND="${RDEPEND}
	dvb? ( virtual/linuxtv-dvb-headers )
"

src_configure() {
	local mycmakeargs=(
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
