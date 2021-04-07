# Copyright 1999-2020 Gentoo Authors
# Copyright 2020 The Trinity Desktop Project
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

TRINITY_EXTRAGEAR_PACKAGING="yes"
TRINITY_HANDBOOK="optional"

TRINITY_LANGS="bg br ca cs cy da de en_GB es et fr ga is
	it lt mt nl pt pt_BR ro ru sr sr@Latn sv ta tr"
TRINITY_MODULE_TYPE="applications"
inherit trinity-base-2

DESCRIPTION="Tool to configure the TDE kiosk framework "
HOMEPAGE="https://trinitydesktop.org/"

LICENSE="|| ( GPL-2 GPL-3 )"
SLOT="14"
IUSE="kcmautostart"

src_configure() {
	local mycmakeargs=(
		-DBUILD_KCM_AUTOSTART="$(usex kcmautostart)"
	)

	trinity-base-2_src_configure
}
