# Copyright 1999-2020 Gentoo Authors
# Copyright 2020 The Trinity Desktop Project
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

TRINITY_EXTRAGEAR_PACKAGING="yes"
TRINITY_HANDBOOK="optional"

TRINITY_LANGS="br cs da de el es et fi fr he hr hu is it ja
	nb nl nn pl pt pt_BR ro ru sk sl sv tr uk zh_TW"
TRINITY_MODULE_TYPE="applications"
inherit trinity-base-2

DESCRIPTION="Email notification utility for TDE"
HOMEPAGE="https://trinitydesktop.org/"

LICENSE="|| ( GPL-2 GPL-3 )"
SLOT="14"
IUSE="asus +ssl"

# SSL support might need tdelibs build with +ssl USE.

src_configure() {
	local mycmakeargs=(
		-DBUILD_TRANSLATIONS=ON
		-DWITH_SSL="$(usex ssl)"
		-DWITH_MLED="$(usex asus)"
	)

	trinity-base-2_src_configure
}
