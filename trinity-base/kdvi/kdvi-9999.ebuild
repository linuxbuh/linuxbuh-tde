# Copyright 1999-2020 Gentoo Authors
# Copyright 2020 The Trinity Desktop Project
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

TRINITY_MODULE_NAME="tdegraphics"
TSM_EXTRACT_ALSO="kviewshell"
inherit trinity-meta-2

DESCRIPTION="Trinity DVI viewer"

DEPEND="
	media-libs/freetype
	~trinity-base/kviewshell-${PV}
"
RDEPEND="${DEPEND}"
