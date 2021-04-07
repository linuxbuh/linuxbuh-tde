# Copyright 1999-2020 Gentoo Authors
# Copyright 2020 The Trinity Desktop Project
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

TRINITY_NEED_ARTS="optional"
TRINITY_MODULE_TYPE="applications"
inherit trinity-base-2

DESCRIPTION="A CD/DVD burning application for Trinity"
HOMEPAGE="https://trinitydesktop.org/"

LICENSE="|| ( GPL-2 GPL-3 )"
SLOT="14"
IUSE="alsa css dvd dvdr emovix encode debug ffmpeg ffmpeg-all-codecs flac
+handbook mp3 sndfile taglib vcd vorbis"

DEPEND="
	media-libs/libsamplerate
	media-libs/taglib
	media-sound/cdparanoia
	alsa? ( media-libs/alsa-lib )
	dvd? ( media-libs/libdvdread )
	encode? ( media-sound/lame )
	ffmpeg? ( media-video/ffmpeg:0= )
	flac? ( media-libs/flac[cxx] )
	mp3? ( media-libs/libmad )
	sndfile? ( media-libs/libsndfile )
	vorbis? ( media-libs/libvorbis )
"
RDEPEND="${DEPEND}
	app-cdr/cdrdao
	media-sound/normalize
	virtual/cdrtools
	css? ( media-libs/libdvdcss )
	dvdr? ( app-cdr/dvd+rw-tools )
	emovix? ( media-video/emovix )
	encode? (
		media-sound/sox
		media-video/transcode[dvd]
	)
	vcd? ( media-video/vcdimager )
"

src_configure() {
	local mycmakeargs=(
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
