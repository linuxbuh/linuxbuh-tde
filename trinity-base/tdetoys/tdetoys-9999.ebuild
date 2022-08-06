# Copyright 1999-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$
EAPI="7"


inherit cmake desktop flag-o-matic gnome2-utils


DESCRIPTION="Tux screensaver for Trinity"
HOMEPAGE="http://trinitydesktop.org/"

if [[ ${PV} = 14.0.999 ]]; then
	inherit git-r3
        EGIT_REPO_URI="https://mirror.git.trinitydesktop.org/cgit/${PN}"
        EGIT_BRANCH="r14.0.x"
	EGIT_SUBMODULES=()
elif [[ ${PV} = 9999 ]]; then
	inherit git-r3
        EGIT_REPO_URI="https://mirror.git.trinitydesktop.org/cgit/${PN}"
	EGIT_SUBMODULES=()
else
	SRC_URI="https://mirror.git.trinitydesktop.org/cgit/${PN}/snapshot/${PN}-r${PV}.tar.gz"
fi

LICENSE="GPL-2"
KEYWORDS="~amd64 ~arm ~arm64 ~x86"
IUSE=""
SLOT="0"

BDEPEND="
	~trinity-base/tde-common-cmake-${PV}
	sys-devel/gettext
	virtual/pkgconfig
	app-misc/fdupes
	dev-util/desktop-file-utils
"
DEPEND="
	~trinity-base/tdelibs-${PV}
	dev-libs/glib:2
	net-dns/libidn
	app-admin/gamin
	virtual/acl
	dev-libs/libpcre
	dev-libs/openssl
"
RDEPEND="${DEPEND}"

if [[ ${PV} = 14.0.999 ]] || [[ ${PV} = 9999 ]]; then
	S="${WORKDIR}/${P}"
else
	S="${WORKDIR}/${PN}-r${PV}"
fi

TQT="/usr/tqt3"
TDEDIR="/usr/trinity/14"

src_configure() {
	cp -rf ${TDEDIR}/share/cmake ${S}/
	unset TDE_FULL_SESSION TDEROOTHOME TDE_SESSION_UID TDEHOME TDE_MULTIHEAD
	export PKG_CONFIG_PATH=$PKG_CONFIG_PATH:${TDEDIR}/$(get_libdir)/pkgconfig
	export QTDIR=$TQT
	export LIBDIR=/opt/trinity/lib
	mycmakeargs=(
#		-DCMAKE_CXX_FLAGS="-L${TQT}/lib"
		-DCMAKE_INSTALL_PREFIX=${TDEDIR}

		-DCMAKE_BUILD_TYPE="RelWithDebInfo"
		-DCMAKE_C_FLAGS="${CFLAGS} -DNDEBUG"
		-DCMAKE_CXX_FLAGS="${CXXFLAGS} -DNDEBUG"
		-DCMAKE_SKIP_RPATH=OFF
		-DCMAKE_INSTALL_RPATH="${TDEDIR}/$(get_libdir)"
		-DCMAKE_VERBOSE_MAKEFILE=ON
		-DWITH_GCC_VISIBILITY=OFF

		-DBIN_INSTALL_DIR="${TDEDIR}/bin"
		-DCONFIG_INSTALL_DIR="/etc/trinity"
		-DDOC_INSTALL_DIR="/usr/share/doc"
		-DINCLUDE_INSTALL_DIR="${TDEDIR}/include"
		-DLIB_INSTALL_DIR="${TDEDIR}/$(get_libdir)"
		-DPKGCONFIG_INSTALL_DIR="${TDEDIR}/$(get_libdir)/pkgconfig"
		-DSHARE_INSTALL_PREFIX="${TDEDIR}/share"
		-DBUILD_ALL=ON
	)

	cmake_src_configure
}

#src_install() {
#	cmake_src_install
#
#}

