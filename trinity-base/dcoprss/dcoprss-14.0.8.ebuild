# Copyright 1999-2017 Gentoo Foundation
# Copyright 2020 The Trinity Desktop Project
# Distributed under the terms of the GNU General Public License v2

EAPI="7"
TRINITY_MODULE_NAME="tdenetwork"

inherit trinity-meta-2

DESCRIPTION="Trinity RSS server and client for DCOP"
KEYWORDS="~amd64 ~x86"

DEPEND="~trinity-base/librss-${PV}"
RDEPEND="${DEPEND}"

TSM_EXTRACT_ALSO="librss/"
