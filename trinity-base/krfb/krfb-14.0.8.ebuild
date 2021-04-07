# Copyright 1999-2020 Gentoo Authors
# Copyright 2020 The Trinity Desktop Project
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

TRINITY_MODULE_NAME="tdenetwork"
inherit trinity-meta-2

DESCRIPTION="VNC-compatible server to share Trinity desktops"

KEYWORDS="~amd64 ~x86"
IUSE="libressl"

DEPEND="
	!libressl? ( dev-libs/openssl:= )
	libressl? ( dev-libs/libressl:= )
	x11-libs/libXext
"
RDEPEND="${DEPEND}"

src_configure() {
	local mycmakeargs=(
		-DWITH_SLP=OFF
	)

	trinity-meta-2_src_configure
}
