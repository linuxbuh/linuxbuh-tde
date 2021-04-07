# Copyright 2020 The Trinity Desktop Project
# Distributed under the terms of the GNU General Public License v2

EAPI="7"
TRINITY_MODULE_TYPE="dependencies"
TRINITY_MODULE_NAME="akode"

inherit trinity-base-2

DESCRIPTION="A simple framework to decode the most common audio formats."
KEYWORDS="~amd64 ~x86"
HOMEPAGE="http://www.trinitydesktop.org/"
LICENSE="|| ( GPL-2 GPL-3 )"
SLOT="0"

IUSE="alsa pulseaudio oss jack +libsamplerate mpc mp3 sndfile vorbis flac speex"

#flac, vorbis, and speex support are all ganged together under 
#WITH_XIPH_DECODER, which will only build if ALL deps are there.
REQUIRED_USE="flac? ( vorbis speex )
	vorbis? ( flac speex )
	speex? ( vorbis flac )"

DEPEND="media-libs/speex
	alsa? ( media-libs/alsa-lib )
	jack? ( virtual/jack )
	pulseaudio? ( media-sound/pulseaudio )
	libsamplerate? ( media-libs/libsamplerate )
	mp3? ( media-libs/libmad )
	flac? ( media-libs/flac )
	mpc? ( dev-libs/mpc )
	vorbis? ( media-libs/libvorbis )
	sndfile? ( media-libs/libsndfile )
	speex? ( media-libs/speex )"
RDEPEND="${DEPEND}"

# The FFMPEG plugin needs some porting, 
# to work with recent FFMPEG. So it is disabled for now.

src_configure() {
	mycmakeargs=(
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
