# Copyright 1999-2020 Gentoo Authors
# Copyright 2020 The Trinity Desktop Project
# Distributed under the terms of the GNU General Public License v2

EAPI="7"
TRINITY_MODULE_NAME="tdebase"

inherit trinity-meta-2

DESCRIPTION="The Trinity application starter panel, capable of applets and extensions"
KEYWORDS="~amd64 ~x86"
IUSE="xcomposite"

DEPEND="~trinity-base/libkonq-${PV}
	~trinity-base/tdebase-data-${PV}
	~dev-libs/dbus-tqt-${PV}
	xcomposite? ( x11-libs/libXrender
		x11-libs/libXfixes
		x11-libs/libXcomposite )"

RDEPEND="${DEPEND}
	~trinity-base/kmenuedit-${PV}"

src_configure() {
	mycmakeargs=(
		-DWITH_XFIXES="$(usex xcomposite)"
		-DWITH_XRENDER="$(usex xcomposite)"
		-DWITH_XCOMPOSITE="$(usex xcomposite)"
	)

	trinity-meta-2_src_configure
}
