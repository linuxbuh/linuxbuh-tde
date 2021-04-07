# Copyright 1999-2020 Gentoo Authors
# Copyright 2020 The Trinity Desktop Project
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

TRINITY_MODULE_NAME="tdegraphics"
inherit trinity-meta-2

DESCRIPTION="SVG viewer library and embeddable kpart"

DEPEND="
	dev-libs/fribidi
	media-libs/fontconfig
	media-libs/freetype
	media-libs/lcms:0
	~media-libs/libart_lgpl-${PV}
"
RDEPEND="${DEPEND}"
