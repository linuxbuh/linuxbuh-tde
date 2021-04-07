# Copyright 1999-2020 Gentoo Authors
# Copyright 2020 The Trinity Desktop Project
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

TRINITY_MODULE_NAME="tdenetwork"
TSM_EXTRACT_ALSO="librss"
inherit trinity-meta-2

DESCRIPTION="kicker plugin: rss news ticker"

DEPEND="~trinity-base/librss-${PV}"
RDEPEND="${DEPEND}"
