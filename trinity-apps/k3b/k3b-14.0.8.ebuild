# Copyright 1999-2009 Gentoo Foundation
# Copyright 2020 The Trinity Desktop Project
# Distributed under the terms of the GNU General Public License v2

EAPI="7"
TRINITY_MODULE_TYPE="applications"

inherit trinity-base-2

DESCRIPTION="A CD/DVD burning application for Trinity"
KEYWORDS="~amd64 ~x86"
HOMEPAGE="http://trinitydesktop.org/"
LICENSE="|| ( GPL-2 GPL-3 )"

need-trinity

need-arts optional

SLOT="${TRINITY_VER}"

IUSE+=" css dvd dvdr vcd debug alsa ffmpeg ffmpeg_all_codecs \
   flac sndfile taglib mp3 vorbis encode emovix +handbook"

DEPEND+=" media-libs/libsamplerate
	media-libs/taglib
	media-sound/cdparanoia
	alsa? ( media-libs/alsa-lib )
	dvd? ( media-libs/libdvdread )
	encode? ( media-sound/lame )
	ffmpeg? ( media-video/ffmpeg )
	flac? ( media-libs/flac[cxx] )
	mp3? ( media-libs/libmad )
	sndfile? ( media-libs/libsndfile )
	vorbis? ( media-libs/libvorbis )"
RDEPEND+=" ${DEPEND}
	app-cdr/cdrdao
	media-sound/normalize
	virtual/cdrtools
	dvdr? ( app-cdr/dvd+rw-tools )
	css? ( media-libs/libdvdcss )
	encode? ( media-sound/sox
		media-video/transcode[dvd] )
	emovix? ( media-video/emovix )
	vcd? ( media-video/vcdimager )"

src_configure() {
	mycmakeargs=(
		-DWITH_HAL=OFF
		-DWITH_SYSTEM_LIBSAMPLERATE=ON
		-DWITH_MUSEPACK=OFF
		-DWITH_MUSICBRAINZ=OFF
		-DBUILD_K3BSETUP=OFF
		-DBUILD_DOC="$(usex handbook)"
		-DWITH_LIBDVDREAD="$(usex dvd)"
		-DWITH_DEBUG="$(usex debug)"
		-DWITH_ALSA="$(usex alsa)"
		-DWITH_FFMPEG="$(usex ffmpeg)"
		-DWITH_FFMPEG_ALL_CODECS="$(usex ffmpeg_all_codecs)"
		-DWITH_FLAC="$(usex flac)"
		-DWITH_SNDFILE="$(usex sndfile)"
		-DWITH_TAGLIB="$(usex taglib)"
		-DWITH_MAD="$(usex mp3)"
		-DWITH_VORBIS="$(usex vorbis)"
		-DWITH_LAME="$(usex encode)"
	)

	trinity-base-2_src_configure
}

pkg_postinst() {
	echo
	elog "We don't install k3bsetup anymore because Gentoo doesn't need it."
	elog "If you get warnings on start-up, uncheck the \"Check system"
	elog "configuration\" option in the \"Misc\" settings window."
	echo

	local group=cdrom
	use kernel_linux || group=operator
	elog "Make sure you have proper read/write permissions on the cdrom device(s)."
	elog "Usually, it is sufficient to be in the ${group} group."
	echo
}
