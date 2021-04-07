# Copyright 1999-2020 Gentoo Authors
# Copyright 2020 The Trinity Desktop Project
# Distributed under the terms of the GNU General Public License v2

EAPI="7"
TRINITY_MODULE_NAME="tdebase"

inherit trinity-meta-2 eutils

DESCRIPTION="Trinity window manager"
KEYWORDS="~amd64 ~x86"

IUSE="xcomposite xrandr xinerama +libconfig +pcre opengl"

DEPEND="x11-libs/libXext
	x11-libs/libXfixes
	x11-libs/libXrender
	xcomposite? ( x11-libs/libXcomposite )
	xinerama? ( x11-base/xorg-proto )
	xrandr? ( x11-libs/libXrandr )
	libconfig? ( dev-libs/libconfig )
	opengl? ( virtual/opengl )
	pcre? ( dev-libs/libpcre[jit] )"
RDEPEND="${DEPEND}"

src_configure() {
	mycmakeargs=(
		-DWITH_XCOMPOSITE="$(usex xcomposite)"
		-DWITH_XFIXES="$(usex xcomposite)"
		-DWITH_XRENDER="$(usex xcomposite)"
		-DWITH_OPENGL="$(usex opengl)"
		-DWITH_XRANDR="$(usex xrandr)"
		-DWITH_LIBCONFIG="$(usex libconfig)"
		-DWITH_PCRE="$(usex pcre)"
		-DWITH_XINERAMA="$(usex xinerama)"
	)

	trinity-meta-2_src_configure
}

pkg_postinst() {
	if ! use xcomposite; then
		for flag in xrandr xinerama libconfig pcre opengl; do
			use $flag && \
				ewarn "USE=\"$flag\" is passed, but it doesn't change anything due to" && \
				ewarn "$flag support in ${P} take effect only if composite is enabled."
		done

	fi
}
