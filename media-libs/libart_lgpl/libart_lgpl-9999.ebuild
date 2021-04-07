# Copyright 1999-2020 Gentoo Authors
# Copyright 2020 The Trinity Desktop Project
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

TRINITY_MODULE_TYPE="dependencies"
TRINITY_MODULE_NAME="libart-lgpl"
inherit trinity-base-2 multilib-minimal

DESCRIPTION="LGPL version of libart maintained by TDE"
HOMEPAGE="https://trinitydesktop.org/"

LICENSE="LGPL-2.1"
SLOT="0"

src_prepare() {
	sed '/ART_SIZEOF_LONG/d' -i src/art_config.h.cmake || die
	cmake-utils_src_prepare
}

multilib_src_configure() {
	cmake-utils_src_configure
}

multilib_src_compile() {
	cmake-utils_src_compile
}

multilib_src_install() {
	cmake-utils_src_install
}
