# Copyright 1999-2020 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$
EAPI="7"

inherit cmake-utils desktop

DESCRIPTION="Audio-decoding framework"
HOMEPAGE="http://trinitydesktop.org/"

if [[ ${PV} = 14.0.999 ]]; then
	inherit git-r3
        EGIT_REPO_URI="https://mirror.git.trinitydesktop.org/cgit/${PN}"
        EGIT_BRANCH="r14.0.x"
	EGIT_SUBMODULES=()
elif [[ ${PV} = 9999 ]]; then
	inherit git-r3
        EGIT_REPO_URI="https://mirror.git.trinitydesktop.org/cgit/${PN}"
	EGIT_SUBMODULES=()
else
	SRC_URI="https://mirror.git.trinitydesktop.org/cgit/${PN}/snapshot/${PN}-r${PV}.tar.gz"
fi

LICENSE="GPL-2"
KEYWORDS="~amd64 ~arm ~arm64 ~x86"
SLOT="0"
IUSE="+alsa +pulseaudio jack +mpc oss +mpeg "

BDEPEND="
	trinity-base/tde-common-cmake
"
DEPEND="
	trinity-base/arts
	mpc? ( dev-libs/mpc )
	dev-libs/libltdl
	alsa? ( media-libs/alsa-lib )
	jack? ( virtual/jack )
	pulseaudio? ( media-sound/pulseaudio )
	mpeg? ( media-libs/libmad )
	media-libs/speex
	media-libs/libsamplerate
	media-libs/flac
	media-libs/libvorbis
	media-libs/libsndfile
"
RDEPEND="$DEPEND"

if [[ ${PV} = 14.0.999 ]] || [[ ${PV} = 9999 ]]; then
	S="${WORKDIR}/${P}"
else
	S="${WORKDIR}/${PN}-r${PV}"
fi

TQT="/usr/tqt3"
TDEDIR="/usr/trinity/14"

src_prepare() {
	cp -rf ${TDEDIR}/share/cmake ${S}/
	cmake-utils_src_prepare
}

src_configure() {
	unset TDE_FULL_SESSION TDEROOTHOME TDE_SESSION_UID TDEHOME TDE_MULTIHEAD
	export PKG_CONFIG_PATH=$PKG_CONFIG_PATH:${TDEDIR}/$(get_libdir)/pkgconfig
	mycmakeargs=(
	-DCMAKE_INSTALL_PREFIX=${TDEDIR}
	-DLIB_INSTALL_DIR="${TDEDIR}/$(get_libdir)"
	-DWITH_LIBLTDL=ON
	-DWITH_ALSA_SINK=$(usex alsa)
	-DWITH_JACK_SINK=$(usex jack)
	-DWITH_PULSE_SINK=$(usex pulseaudio)
	-DWITH_OSS_SINK=$(usex oss)
	-DWITH_SUN_SINK=OFF
	-DWITH_FFMPEG_DECODER=OFF
	-DWITH_MPC_DECODER=$(usex mpc)
	-DWITH_MPEG_DECODER=$(usex mpeg)
	-DWITH_SRC_RESAMPLER=ON
	-DWITH_XIPH_DECODER=ON

	)

	 cmake-utils_src_configure
}
