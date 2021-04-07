# Copyright 2020 The Trinity Desktop Project
# Distributed under the terms of the GNU General Public License v2

EAPI="7"
TRINITY_MODULE_TYPE="applications"

TRINITY_EXTRAGEAR_PACKAGING="yes"
TRINITY_HANDBOOK="optional"

TRINITY_LANGS="bs de es fr hu it ja nl
	pl pt_BR ru sl sv tr zh_CN zh_TW"

inherit trinity-base-2

DESCRIPTION="A powerful batch file renamer for TDE"
KEYWORDS="~amd64 ~x86"
HOMEPAGE="http://trinitydesktop.org/"
LICENSE="|| ( GPL-2 GPL-3 )"

need-trinity

SLOT="${TRINITY_VER}"

src_configure() {
	mycmakeargs=(
		-DBUILD_TRANSLATIONS=ON
	)

	trinity-base-2_src_configure
}

pkg_postinst () {
	echo
	einfo "Please note that KRename can use TDE's file information plugins as they're"
	einfo "available, so you might want to install one or more of the following ebuilds:"
	echo
	einfo "tdeaddons-tdefile-plugins, tdeadmin-tdefile-plugins,"
	einfo "tdegraphics-tdefile-plugins, tdemultimedia-tdefile-plugins,"
	einfo "tdenetwork-tdefile-plugins, tdesdk-tdefile-plugins."
	echo
}