# Copyright 2020 The Trinity Desktop Project
# Distributed under the terms of the GNU General Public License v2

EAPI="7"
TRINITY_MODULE_TYPE="applications"

TRINITY_EXTRAGEAR_PACKAGING="yes"
TRINITY_HANDBOOK="optional"

TRINITY_LANGS="cs de es en_GB fr nl pl pt_BR ru zh_CN"

inherit trinity-base-2

DESCRIPTION="TDE dialogs in GTK 2.x applications "
KEYWORDS="~amd64 ~x86"
HOMEPAGE="http://trinitydesktop.org/"
LICENSE="|| ( GPL-2 GPL-3 )"

need-trinity

SLOT="${TRINITY_VER}"

IUSE+=" tqt tde gtk2"

DEPEND+="
	tqt? ( ~dev-tqt/tqtinterface-${PV} )
	gtk2? ( x11-libs/gtk+:2 )
"
RDEPEND+=" ${DEPEND}"

src_configure() {
	mycmakeargs=(
		-DBUILD_KGTK_TQT="$(usex tqt)"
		-DBUILD_KGTK_TDE="$(usex tde)"
		-DBUILD_KGTK_GTK2="$(usex gtk2)"
	)

	trinity-base-2_src_configure
}
