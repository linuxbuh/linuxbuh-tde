# Copyright 2020 Gentoo Authors
# Copyright 2020 The Trinity Desktop Project
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

TRINITY_MODULE_TYPE="applications"
inherit trinity-base-2

DESCRIPTION="K3b - internationalization translations"
HOMEPAGE="https://trinitydesktop.org/"

LICENSE="|| ( GPL-2 GPL-3 )"
SLOT="14"
IUSE="+handbook"

src_configure() {
	local mycmakeargs=(
		-DBUILD_MESSAGES=ON
		-DBUILD_DOC="$(usex handbook)"
	)
	trinity-base-2_src_configure
}
