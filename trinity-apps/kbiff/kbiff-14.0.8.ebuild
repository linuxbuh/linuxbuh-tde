# Copyright 2020 The Trinity Desktop Project
# Distributed under the terms of the GNU General Public License v2

EAPI="7"
TRINITY_MODULE_TYPE="applications"

TRINITY_EXTRAGEAR_PACKAGING="yes"
TRINITY_HANDBOOK="optional"

TRINITY_LANGS="br cs da de el es et fi fr he hr hu is it ja
	nb nl nn pl pt pt_BR ro ru sk sl sv tr uk zh_TW"

inherit trinity-base-2

DESCRIPTION="Email notification utility for TDE"
KEYWORDS="~amd64 ~x86"
HOMEPAGE="http://trinitydesktop.org/"
LICENSE="|| ( GPL-2 GPL-3 )"

need-trinity

SLOT="${TRINITY_VER}"

IUSE+=" +ssl asus"

# SSL support might need tdelibs build with +ssl USE.

src_configure() {
	mycmakeargs=(
		-DBUILD_TRANSLATIONS=ON
		-DWITH_SSL="$(usex ssl)"
		-DWITH_MLED="$(usex asus)"
	)

	trinity-base-2_src_configure
}
