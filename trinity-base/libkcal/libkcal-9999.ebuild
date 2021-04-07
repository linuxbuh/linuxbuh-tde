# Copyright 1999-2020 Gentoo Authors
# Copyright 2020 The Trinity Desktop Project
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

TRINITY_MODULE_NAME="tdepim"
TSM_EXTRACT_ALSO="libemailfunctions/ libtdepim/ libkmime/ ktnef/"
inherit trinity-meta-2

DESCRIPTION="Trinity kcal library for KOrganizer etc"

DEPEND="
	dev-libs/libical
	~trinity-base/ktnef-${PV}
	~trinity-base/libkmime-${PV}"
RDEPEND="${DEPEND}"
