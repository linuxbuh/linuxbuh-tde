# Copyright 1999-2020 Gentoo Authors
# Copyright 2020 The Trinity Desktop Project
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

TRINITY_EXTRAGEAR_PACKAGING="yes"
TRINITY_HANDBOOK="optional"

TRINITY_LANGS="ar bg cs de es fr hu it nl pl pt_BR ru sk sv tr zh_CN"

TRINITY_DOC_LANGS="de"
TRINITY_MODULE_TYPE="applications"
inherit trinity-base-2

DESCRIPTION="A graphical shutdown utility for TDE"
HOMEPAGE="https://trinitydesktop.org/"

LICENSE="|| ( GPL-2 GPL-3 )"
SLOT="14"
IUSE="extras"

RDEPEND="
	~trinity-base/kcontrol-${PV}
	~trinity-base/kdialog-${PV}
	~trinity-base/tdesu-${PV}
"

src_configure() {
	local mycmakeargs=(
		-DBUILD_TRANSLATIONS=ON
		-DBUILD_EXTRAS="$(usex extras)"
	)

	trinity-base-2_src_configure
}
