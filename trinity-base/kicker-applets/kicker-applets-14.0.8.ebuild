# Copyright 1999-2017 Gentoo Foundation
# Copyright 2020 The Trinity Desktop Project
# Distributed under the terms of the GNU General Public License v2

EAPI="7"
TRINITY_MODULE_NAME="tdeaddons"

inherit trinity-meta-2

DESCRIPTION="kicker applets"
KEYWORDS="~amd64 ~x86"

DEPEND="~trinity-base/kicker-${PV}"
RDEPEND="${DEPEND}"

# no xmms support
