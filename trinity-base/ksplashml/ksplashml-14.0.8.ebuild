# Copyright 1999-2020 Gentoo Authors
# Copyright 2020 The Trinity Desktop Project
# Distributed under the terms of the GNU General Public License v2

EAPI="7"
TRINITY_MODULE_NAME="tdebase"

inherit trinity-meta-2

DESCRIPTION="Trinity splashscreen framework (of Trinity itself, not of individual apps)"
KEYWORDS="~amd64 ~x86"

IUSE="xinerama"

DEPEND="xinerama? ( x11-base/xorg-proto )"
RDEPEND="${DEPEND}"

src_configure() {
	mycmakeargs=(
		-DWITH_XINERAMA="$(usex xinerama)"
	)

	trinity-meta-2_src_configure
}
