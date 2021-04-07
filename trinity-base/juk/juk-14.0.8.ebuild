# Copyright 2020 The Trinity Desktop Project
# Distributed under the terms of the GNU General Public License v2

EAPI="7"
TRINITY_MODULE_NAME="tdemultimedia"

inherit trinity-meta-2

DESCRIPTION="Jukebox and music manager for TDE"
KEYWORDS="~amd64 ~x86"

IUSE="gstreamer musicbrainz"

RDEPEND="media-libs/akode
	media-libs/taglib
	gstreamer? ( media-libs/gst-plugins-base )
	musicbrainz? ( media-libs/musicbrainz )"
DEPEND="${RDEPEND}"

PDEPEND="gstreamer? ( media-plugins/gst-plugins-meta )"

src_configure() {
	mycmakeargs=(
		-DWITH_GSTREAMER="$(usex gstreamer)"
		-DWITH_MUSICBRAINZ="$(usex musicbrainz)"
	)

	trinity-meta-2_src_configure
}
