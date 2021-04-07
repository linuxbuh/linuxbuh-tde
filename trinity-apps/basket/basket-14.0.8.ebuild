# Copyright 2020 The Trinity Desktop Project
# Distributed under the terms of the GNU General Public License v2

EAPI="7"
TRINITY_MODULE_TYPE="applications"

TRINITY_EXTRAGEAR_PACKAGING="yes"
TRINITY_HANDBOOK="optional"

TRINITY_LANGS="cs da de es fr it ja nl nn pl_PL pt ru sk tr zh_CN zh_TW"

inherit trinity-base-2

DESCRIPTION="A multi-purpose note-taking application for TDE"
KEYWORDS="~amd64 ~x86"
HOMEPAGE="http://trinitydesktop.org/"
LICENSE="|| ( GPL-2 GPL-3 )"

need-trinity

need-arts optional

SLOT="${TRINITY_VER}"

IUSE+=" crypt +svg kontact"

DEPEND+=" crypt? ( app-crypt/gpgme )
	svg? ( ~media-libs/libart_lgpl-${PV} )
	kontact? ( ~trinity-base/kontact-${PV} )"
RDEPEND+=" ${DEPEND}"

src_configure() {
	mycmakeargs=(
		-DBUILD_TRANSLATIONS=ON
		-DBUILD_KONTACT_PLUGIN="$(usex kontact)"
		-DWITH_LIBART="$(usex svg)"
		-DWITH_GPGME="$(usex crypt)"
	)

	trinity-base-2_src_configure
}
