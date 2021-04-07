# Copyright 2020 The Trinity Desktop Project
# Distributed under the terms of the GNU General Public License v2

EAPI="7"
TRINITY_MODULE_TYPE="applications"

inherit trinity-base-2

DESCRIPTION="K3b - internationalization translations"
KEYWORDS="~amd64 ~x86"
HOMEPAGE="http://trinitydesktop.org/"
LICENSE="|| ( GPL-2 GPL-3 )"

need-trinity

SLOT="${TRINITY_VER}"

IUSE+=" +handbook"

src_configure() {
	mycmakeargs=(
		-DBUILD_MESSAGES=ON
		-DBUILD_DOC="$(usex handbook)"
	)

	trinity-base-2_src_configure
}
