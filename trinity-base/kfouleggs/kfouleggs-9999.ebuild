# Copyright 1999-2020 Gentoo Authors
# Copyright 2020 The Trinity Desktop Project
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

TRINITY_MODULE_NAME="tdegames"
TRINITY_SUBMODULE="kfouleggs libksirtet"
TSM_EXTRACT_ALSO="libtdegames/"
inherit trinity-meta-2

DESCRIPTION="KFoulEggs is an adaptation of the well-known (at least in Japan) PuyoPuyo game"

DEPEND="~trinity-base/libtdegames-${PV}"
RDEPEND="${DEPEND}"
