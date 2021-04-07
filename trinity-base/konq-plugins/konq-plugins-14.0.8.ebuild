# Copyright 1999-2017 Gentoo Foundation
# Copyright 2020 The Trinity Desktop Project
# Distributed under the terms of the GNU General Public License v2

EAPI="7"
TRINITY_MODULE_NAME="tdeaddons"

inherit trinity-meta-2

need-arts optional

DESCRIPTION="Various plugins for Konqueror."
KEYWORDS="~amd64 ~x86"

MY_DEPEND="~trinity-base/konqueror-${PV}"
DEPEND+=" ${MY_DEPEND}"
RDEPEND+=" ${MY_DEPEND}"
