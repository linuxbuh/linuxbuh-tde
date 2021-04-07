# Copyright 1999-2020 Gentoo Authors
# Copyright 2020 The Trinity Desktop Project
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

TRINITY_EXTRAGEAR_PACKAGING="yes"
TRINITY_HANDBOOK="optional"

TRINITY_LANGS="ar ca de es fr nb pl pt_BR sv zh_CN zh_TW"
TRINITY_MODULE_TYPE="applications"
inherit trinity-base-2

DESCRIPTION="User friendly TDE frontend for wireless network connection"
HOMEPAGE="https://trinitydesktop.org/"

LICENSE="|| ( GPL-2 GPL-3 )"
SLOT="14"

RDEPEND="
	net-wireless/wireless-tools
	|| (
		net-misc/dhcp
		net-misc/dhcpcd
	)
"
