# Copyright 2020 The Trinity Desktop Project
# Distributed under the terms of the GNU General Public License v2

EAPI="7"
TRINITY_MODULE_NAME="tdemultimedia"

inherit trinity-meta-2

DESCRIPTION="tdefile plugins from tdemultimedia"
KEYWORDS="~amd64 ~x86"

IUSE="taglib theora vorbis"

DEPEND="
	taglib? ( media-libs/taglib )
	theora? ( media-libs/libtheora  )
	vorbis? ( media-libs/libvorbis )"
RDEPEND="${DEPEND}"

src_configure() {
	mycmakeargs=(
		-DWITH_TAGLIB="$(usex taglib)"
		-DWITH_THEORA="$(usex theora)"
		-DWITH_VORBIS="$(usex vorbis)"
	)

	trinity-meta-2_src_configure
}
