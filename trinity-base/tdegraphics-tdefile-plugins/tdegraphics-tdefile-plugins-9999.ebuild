# Copyright 1999-2020 Gentoo Authors
# Copyright 2020 The Trinity Desktop Project
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

TRINITY_MODULE_NAME="tdegraphics"
TSM_EXTRACT_ALSO="kghostview/dscparse/"
inherit trinity-meta-2

DESCRIPTION="tdefile plugins from tdegraphics"

IUSE="tiff openexr pdf"

DEPEND="
	tiff? ( media-libs/tiff:= )
	openexr? ( media-libs/openexr )
	pdf? ( app-text/poppler )"
RDEPEND="${DEPEND}"

src_configure() {
	local mycmakeargs=(
		-DWITH_TIFF="$(usex tiff)"
		-DWITH_OPENEXR="$(usex openexr)"
		-DWITH_PDF="$(usex pdf)"
	)

	trinity-meta-2_src_configure
}
