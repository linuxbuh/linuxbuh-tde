# Copyright 1999-2020 Gentoo Authors
# Copyright 2020 The Trinity Desktop Project
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

TRINITY_NEED_ARTS="optional"
TRINITY_MODULE_NAME="tdegames"
TSM_EXTRACT_ALSO="libtdegames/"
inherit trinity-meta-2

# Needs some dependency to play "au" sounds.

DESCRIPTION="Trinity Bounce Ball Game"

DEPEND="~trinity-base/libtdegames-${PV}"
RDEPEND="${DEPEND}"
