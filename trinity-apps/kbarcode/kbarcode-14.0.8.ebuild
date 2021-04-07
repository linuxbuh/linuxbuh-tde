# Copyright 2020 The Trinity Desktop Project
# Distributed under the terms of the GNU General Public License v2

EAPI="7"
TRINITY_MODULE_TYPE="applications"

TRINITY_EXTRAGEAR_PACKAGING="yes"
TRINITY_HANDBOOK="optional"

TRINITY_LANGS="de el es fi fr hu it nl pl sv tr"

inherit trinity-base-2

DESCRIPTION="Barcode and label printing application for TDE"
KEYWORDS="~amd64 ~x86"
HOMEPAGE="http://trinitydesktop.org/"
LICENSE="|| ( GPL-2 GPL-3 )"

need-trinity

SLOT="${TRINITY_VER}"

# Native GNU Barcode support seems to be broken right now.
# The GNU Barcode binary is needed anyway.
# Might be related to the following tidbit from Gentoo user ML:
#"As of version 0.99, GNU Barcode no longer installs its library."

IUSE+=" javascript native_gnu_barcode"

RDEPEND+=" app-text/barcode
	|| ( media-gfx/imagemagick
	media-gfx/graphicsmagick )"

src_configure() {
	mycmakeargs=(
		-DBUILD_TRANSLATIONS=ON
		-DWITH_NATIVE_GNU_BARCODE="$(usex native_gnu_barcode)"
		-DWITH_JAVASCRIPT="$(usex javascript)"
	)

	trinity-base-2_src_configure
}
