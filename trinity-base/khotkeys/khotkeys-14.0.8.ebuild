# Copyright 1999-2020 Gentoo Authors
# Copyright 2020 The Trinity Desktop Project
# Distributed under the terms of the GNU General Public License v2

EAPI="7"
TRINITY_MODULE_NAME="tdebase"

inherit trinity-meta-2

need-arts optional

DESCRIPTION="Trinity hotkey daemon"
KEYWORDS="~amd64 ~x86"

DEPEND="x11-libs/libXtst"
RDEPEND="${DEPEND}"

src_configure() {
	mycmakeargs=(
		-DWITH_XTEST=ON
	)

	trinity-meta-2_src_configure
}
