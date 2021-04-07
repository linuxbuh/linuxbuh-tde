# Copyright 1999-2020 Gentoo Authors
# Copyright 2020 The Trinity Desktop Project
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

TRINITY_MODULE_NAME="tdebase"
TSM_EXTRACT_ALSO="translations/"
inherit trinity-meta-2

DESCRIPTION="Trinity screensaver framework"

IUSE="opengl +krootbacking"

DEPEND="x11-libs/libXt
	opengl? ( virtual/opengl )
	krootbacking? ( ~trinity-base/krootbacking-${PV} )"
RDEPEND="${DEPEND}"

src_configure () {
	local mycmakeargs=(
		-DWITH_OPENGL="$(usex opengl)"
	)

	trinity-meta-2_src_configure
}
