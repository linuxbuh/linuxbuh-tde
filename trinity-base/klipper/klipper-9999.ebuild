# Copyright 1999-2020 Gentoo Authors
# Copyright 2020 The Trinity Desktop Project
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

TRINITY_MODULE_NAME="tdebase"
inherit trinity-meta-2

DESCRIPTION="kicker applet for Trinity and X clipboard management"

DEPEND="x11-libs/libXfixes"
RDEPEND="${DEPEND}"

src_configure() {
	local mycmakeargs=(
		-DWITH_XFIXES=ON
	)

	trinity-meta-2_src_configure
}
