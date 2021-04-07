# Copyright 2020 The Trinity Desktop Project
# Distributed under the terms of the GNU General Public License v2

EAPI="7"
TRINITY_MODULE_TYPE="applications"

TRINITY_EXTRAGEAR_PACKAGING="yes"
TRINITY_HANDBOOK="optional"

TRINITY_LANGS="ar bg cs cy da de el es et fr ga gl hu it
	ja ka lt nl pl pt pt_BR ru rw sk sr sr@Latn sv tr"

inherit trinity-base-2

DESCRIPTION="Network interfaces monitor for the TDE systray"
KEYWORDS="~amd64 ~x86"
HOMEPAGE="http://trinitydesktop.org/"
LICENSE="|| ( GPL-2 GPL-3 )"

need-trinity

SLOT="${TRINITY_VER}"

IUSE+=" wifi kernel_linux"

RDEPEND+=" kernel_linux? ( sys-apps/net-tools )
	wifi? ( net-wireless/wireless-tools )"

pkg_postinst() {
	echo
	einfo "KNemo is not an executable but a KDED service. KNemo has to be"
	einfo "started using TDE Control Center/Internet & Network/Network Monitor"
	echo
}
