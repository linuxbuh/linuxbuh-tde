# Copyright 1999-2020 Gentoo Authors
# Copyright 2020 The Trinity Desktop Project
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

TRINITY_MODULE_NAME="tdemultimedia"
TRINITY_SUBMODULE="tdeioslave"
TSM_EXTRACT="tdeioslave"
inherit trinity-meta-2

DESCRIPTION="Multimedia Trinity TDEIOslaves"

IUSE="cdparanoia flac"

DEPEND="
	cdparanoia? ( media-sound/cdparanoia )
	flac? ( media-libs/flac )"
RDEPEND="${DEPEND}"

src_configure() {
	local mycmakeargs=(
		-DWITH_FLAC=$(usex flac)
		-DWITH_CDPARANOIA=$(usex cdparanoia)
	)

	trinity-meta-2_src_configure
}
