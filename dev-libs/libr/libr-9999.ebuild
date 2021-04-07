# Copyright 1999-2020 Gentoo Authors
# Copyright 2020 The Trinity Desktop Project
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

TRINITY_MODULE_TYPE="dependencies"
TRINITY_MODULE_NAME="libr"
inherit trinity-base-2

DESCRIPTION="ELF resource access and editing library"
HOMEPAGE="https://trinitydesktop.org/"

LICENSE="LGPL-2.1"
SLOT="0"

DEPEND="sys-libs/binutils-libs:="
DEPEND="${RDEPEND}
	app-doc/doxygen
"

src_configure() {
	local mycmakeargs=(
		-DWITH_BACKEND_LIBBFD=ON
		-DWITH_BACKEND_LIBELF=OFF
		-DWITH_BACKEND_READONLY=OFF
	 )
	cmake-utils_src_configure
}
