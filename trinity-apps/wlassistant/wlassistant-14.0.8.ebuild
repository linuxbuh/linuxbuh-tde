# Copyright 2020 The Trinity Desktop Project
# Distributed under the terms of the GNU General Public License v2

EAPI="7"
TRINITY_MODULE_TYPE="applications"

TRINITY_EXTRAGEAR_PACKAGING="yes"
TRINITY_HANDBOOK="optional"

TRINITY_LANGS="ar ca de es fr nb pl pt_BR sv zh_CN zh_TW"

inherit trinity-base-2

DESCRIPTION="User friendly TDE frontend for wireless network connection"
KEYWORDS="~amd64 ~x86"
HOMEPAGE="http://trinitydesktop.org/"
LICENSE="|| ( GPL-2 GPL-3 )"

need-trinity

SLOT="${TRINITY_VER}"

RDEPEND+=" 
	net-wireless/wireless-tools
	|| ( net-misc/dhcp net-misc/dhcpcd )
"
