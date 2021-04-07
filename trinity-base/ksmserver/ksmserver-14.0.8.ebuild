# Copyright 1999-2020 Gentoo Authors
# Copyright 2020 The Trinity Desktop Project
# Distributed under the terms of the GNU General Public License v2

EAPI="7"
TRINITY_MODULE_NAME="tdebase"

inherit trinity-meta-2

DESCRIPTION="The reliable Trinity session manager that talks the standard X11R6"
KEYWORDS="~amd64 ~x86"
IUSE="+hwlib"

src_configure() {
	mycmakeargs=(
		-DWITH_TDEHWLIB="$(usex hwlib)"
	)

	trinity-meta-2_src_configure
}
