# Copyright 1999-2020 Gentoo Authors
# Copyright 2020 The Trinity Desktop Project
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

TRINITY_MODULE_NAME="tdegames"
TRINITY_SUBMODULE="ksirtet libksirtet"
TSM_EXTRACT_ALSO="libtdegames/"
inherit trinity-meta-2

DESCRIPTION="KSirtet is an adaptation of the well-known Tetris game"

DEPEND="~trinity-base/libtdegames-${PV}"
RDEPEND="${DEPEND}"
