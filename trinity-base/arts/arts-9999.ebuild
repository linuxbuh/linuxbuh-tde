# Copyright 1999-2020 Gentoo Authors
# Copyright 2020 The Trinity Desktop Project
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

TRINITY_MODULE_TYPE="dependencies"
TRINITY_MODULE_NAME="arts"
inherit trinity-base-2

DESCRIPTION="aRts, the Trinity sound (and all-around multimedia) server/output manager"
HOMEPAGE="https://trinitydesktop.org/"

LICENSE="|| ( GPL-2 GPL-3 )"

IUSE="alsa -artswrappersuid jack mp3 vorbis"
SLOT="14"

DEPEND="~dev-tqt/tqtinterface-${PV}
	dev-libs/glib
	media-libs/audiofile
	mp3? ( media-libs/libmad )
	alsa? ( media-libs/alsa-lib )
	vorbis? ( media-libs/libogg media-libs/libvorbis )
	jack? ( media-sound/jack-audio-connection-kit )"
RDEPEND="${DEPEND}"

src_configure() {
	local mycmakeargs=(
		-DWITH_AUDIOFILE=ON
		-DWITH_MAD="$(usex mp3)"
		-DWITH_ALSA="$(usex alsa)"
		-DWITH_VORBIS="$(usex vorbis)"
		-DWITH_JACK="$(usex jack)"
		-DWITH_ESOUND=OFF
		-DWITH_SNDIO=OFF
	)

	trinity-base-2_src_configure
}

src_install() {
	trinity-base-2_src_install

	# Used for realtime priority, but off by default as it is a security hazard
	use artswrappersuid && chmod u+s "${D}/${TDEDIR}/bin/artswrapper"
}

pkg_postinst() {
	if ! use artswrappersuid ; then
		elog "Run chmod u+s ${TDEDIR}/bin/artswrapper to let artsd use realtime"
		elog "priority and so avoid possible skips in sound. However, on untrusted systems"
		elog "this creates the possibility of a DoS attack that'll use 100% cpu at realtime"
		elog "priority, and so is off by default. See Gentoo bug #7883."
		elog "Or, you can set the artswrappersuid USE flag to make the ebuild do this."
	fi
}
