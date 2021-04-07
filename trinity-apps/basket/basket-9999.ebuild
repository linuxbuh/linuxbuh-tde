# Copyright 1999-2020 Gentoo Authors
# Copyright 2020 The Trinity Desktop Project
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

TRINITY_EXTRAGEAR_PACKAGING="yes"
TRINITY_HANDBOOK="optional"

TRINITY_LANGS="cs da de es fr it ja nl nn pl_PL pt ru sk tr zh_CN zh_TW"
TRINITY_NEED_ARTS="optional"
TRINITY_MODULE_TYPE="applications"
inherit trinity-base-2

DESCRIPTION="Multi-purpose note-taking application for TDE"
HOMEPAGE="https://trinitydesktop.org/"

LICENSE="|| ( GPL-2 GPL-3 )"
SLOT="14"
IUSE="crypt kontact +svg"

DEPEND="
	crypt? ( app-crypt/gpgme )
	kontact? ( ~trinity-base/kontact-${PV} )
	svg? ( ~media-libs/libart_lgpl-${PV} )"
RDEPEND="${DEPEND}"

src_configure() {
	local mycmakeargs=(
		-DBUILD_TRANSLATIONS=ON
		-DBUILD_KONTACT_PLUGIN="$(usex kontact)"
		-DWITH_LIBART="$(usex svg)"
		-DWITH_GPGME="$(usex crypt)"
	)

	trinity-base-2_src_configure
}
