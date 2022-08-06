# Copyright 1999-2021 Gentoo Authors
# Copyright 2021 The Trinity Desktop Project
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

TRINITY_MODULE_TYPE="dependencies"
TRINITY_MODULE_NAME="tqtinterface"
inherit trinity-base-2




DESCRIPTION="Interface and abstraction library for TQt and Trinity"
HOMEPAGE="https://trinitydesktop.org/"

LICENSE="|| ( GPL-2 GPL-3 )"
SLOT="0"
if [[ ${PV} != *9999* ]] ; then
    KEYWORDS="~amd64 ~arm64 ~x86"
fi
IUSE="+opengl"

DEPEND="~dev-tqt/tqt-${PV}[opengl=]
	opengl? ( virtual/glu )"
RDEPEND="${DEPEND}"

pkg_setup() {
	export TQTDIR="/usr/tqt3"
}

src_configure() {
	local mycmakeargs=(
		-DQT_PREFIX_DIR="${TQTDIR}"
		-DUSE_QT3=ON
	)

	cmake_src_configure
}
