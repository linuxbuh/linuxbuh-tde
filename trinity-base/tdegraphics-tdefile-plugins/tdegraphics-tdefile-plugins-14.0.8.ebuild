# Copyright 1999-2017 Gentoo Foundation
# Copyright 2020 The Trinity Desktop Project
# Distributed under the terms of the GNU General Public License v2

EAPI="7"
TRINITY_MODULE_NAME="tdegraphics"

inherit trinity-meta-2

DESCRIPTION="tdefile plugins from tdegraphics"
KEYWORDS="~amd64 ~x86"

IUSE="tiff openexr pdf"

DEPEND="
	tiff? ( media-libs/tiff:= )
	openexr? ( media-libs/openexr )
	pdf? ( app-text/poppler )"
RDEPEND="${DEPEND}"

TSM_EXTRACT_ALSO="kghostview/dscparse/"

src_configure() {
	mycmakeargs=(
		-DWITH_TIFF="$(usex tiff)"
		-DWITH_OPENEXR="$(usex openexr)"
		-DWITH_PDF="$(usex pdf)"
	)

	trinity-meta-2_src_configure
}
