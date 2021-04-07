# Copyright 2019-2020 The Trinity Desktop Project
# Distributed under the terms of the GNU General Public License v2

EAPI="7"
TRINITY_MODULE_TYPE="applications"

TRINITY_EXTRAGEAR_PACKAGING="yes"
TRINITY_HANDBOOK="optional"

TRINITY_LANGS="ar bg cs da de el es fi fr hi hu it ja km lt
	nb nl pa pl pt pt_BR ru sl_SI sv tr uk zh_CN zh_TW"

TRINITY_DOC_LANGS="cs de fi hu nb"

inherit trinity-base-2

DESCRIPTION="A TDE frontend for power management"
KEYWORDS="~amd64 ~x86"
HOMEPAGE="http://trinitydesktop.org/"
LICENSE="|| ( GPL-2 GPL-3 )"

need-trinity

SLOT="${TRINITY_VER}"

DEPEND+=" x11-libs/libXScrnSaver
	x11-libs/libXext
	x11-libs/libXtst
	~dev-libs/dbus-1-tqt-${PV}"
RDEPEND+=" ${DEPEND}"

src_configure() {
	mycmakeargs=(
		-DBUILD_TRANSLATIONS=ON
	)

	trinity-base-2_src_configure
}
