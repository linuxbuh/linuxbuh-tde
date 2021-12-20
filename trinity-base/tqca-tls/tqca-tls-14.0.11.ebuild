# Copyright 1999-2019 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI="7"

inherit cmake-utils

DESCRIPTION=""
HOMEPAGE="http://trinitydesktop.org/"

if [[ ${PV} = 14.0.999 ]]; then
	inherit git-r3
        EGIT_REPO_URI="https://mirror.git.trinitydesktop.org/cgit/${PN}"
        EGIT_BRANCH="r14.0.x"
elif [[ ${PV} = 9999 ]]; then
	inherit git-r3
        EGIT_REPO_URI="https://mirror.git.trinitydesktop.org/cgit/${PN}"
else
	SRC_URI="https://mirror.git.trinitydesktop.org/cgit/${PN}/snapshot/${PN}-r${PV}.tar.gz"
fi

LICENSE="GPL-2 LGPL-2"
KEYWORDS="~arm ~arm64 ~x86 ~amd64"
SLOT="0"
IUSE=""

BDEPEND="
        ~trinity-base/tde-common-cmake-${PV}
"

DEPEND="
	>=dev-tqt/tqtinterface-${PV}
	dev-libs/openssl
"
RDEPEND="$DEPEND"

if [[ ${PV} = 14.0.999 ]] || [[ ${PV} = 9999 ]]; then
	S="${WORKDIR}/${P}"
else
	S="${WORKDIR}/${PN}-r${PV}"
fi

TQT="/usr/tqt3"
TDEDIR="/usr/trinity/14"

src_prepare() {
        cp -rf ${TDEDIR}/share/cmake .
        cmake-utils_src_prepare
}

src_configure() {
        unset TDE_FULL_SESSION TDEROOTHOME TDE_SESSION_UID TDEHOME TDE_MULTIHEAD
        export PKG_CONFIG_PATH=$PKG_CONFIG_PATH:${TDEDIR}/$(get_libdir)/pkgconfig
        mycmakeargs=(
                -DCMAKE_INSTALL_PREFIX=${TDEDIR}
                -DWITH_GCC_VISIBILITY=OFF
                -DLIB_INSTALL_DIR="${TDEDIR}/$(get_libdir)")
        cmake-utils_src_configure
}

src_install() {
        cmake-utils_src_install
}
