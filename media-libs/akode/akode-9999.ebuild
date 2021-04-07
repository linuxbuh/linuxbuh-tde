# Copyright 1999-2020 Gentoo Authors
# Copyright 2020 The Trinity Desktop Project
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

TRINITY_MODULE_TYPE="dependencies"
TRINITY_MODULE_NAME="akode"
inherit trinity-base-2

DESCRIPTION="Simple framework to decode the most common audio formats"
HOMEPAGE="https://trinitydesktop.org/"

LICENSE="|| ( GPL-2 GPL-3 )"
SLOT="0"
IUSE="alsa flac jack +libsamplerate mp3 mpc oss pulseaudio sndfile speex vorbis"

DEPEND="
	alsa? ( media-libs/alsa-lib )
	flac? ( media-libs/flac )
	jack? ( virtual/jack )
	libsamplerate? ( media-libs/libsamplerate )
	mp3? ( media-libs/libmad )
	mpc? ( dev-libs/mpc )
	pulseaudio? ( media-sound/pulseaudio )
	sndfile? ( media-libs/libsndfile )
	speex? ( media-libs/speex )
	vorbis? ( media-libs/libvorbis )
"
RDEPEND="${DEPEND}"

# The FFMPEG plugin needs some porting, 
# to work with recent FFMPEG. So it is disabled for now.

src_configure() {
	local mycmakeargs=(
		-DWITH_FFMPEG_DECODER=OFF
		-DWITH_SUN_SINK=OFF
		-DWITH_LIBLTDL=OFF
		-DWITH_ALSA_SINK=$(usex alsa)
		-DWITH_OSS_SINK=$(usex oss)
		-DWITH_PULSE_SINK=$(usex pulseaudio)
		-DWITH_JACK_SINK=$(usex jack)
		-DWITH_MPEG_DECODER=$(usex mp3)
		-DWITH_XIPH_DECODER=$(usex vorbis)
		-DWITH_MPC_DECODER=$(usex mpc)
		-DWITH_SRC_RESAMPLER=$(usex libsamplerate)
	)

	cmake-utils_src_configure
}
