# Copyright 1999-2020 Gentoo Authors
# Copyright 2020 The Trinity Desktop Project
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

TRINITY_MODULE_NAME="tdebase"
TSM_EXTRACT_ALSO="translations/"
inherit trinity-meta-2

DESCRIPTION="X terminal for use with Trinity"

IUSE="sudo"

DEPEND="
	x11-libs/libX11
	x11-libs/libXrender"

RDEPEND="${DEPEND}
	~trinity-base/kcontrol-${PV}
	x11-apps/bdftopcf
	sudo? ( app-admin/sudo )"

src_configure() {
	local mycmakeargs=(
		-DWITH_XRENDER=ON
		-DWITH_SUDO_KONSOLE_SUPER_USER_COMMAND="$(usex sudo)"
	)

	trinity-meta-2_src_configure
}
