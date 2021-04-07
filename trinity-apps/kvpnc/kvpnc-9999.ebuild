# Copyright 1999-2020 Gentoo Authors
# Copyright 2020 The Trinity Desktop Project
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

TRINITY_EXTRAGEAR_PACKAGING="yes"
TRINITY_HANDBOOK="optional"

TRINITY_LANGS="bg ca da de es fr hu it ja nl pl pt_BR ru sk sv tr zh_CN"
TRINITY_MODULE_TYPE="applications"
inherit trinity-base-2

DESCRIPTION="VPN clients frontend for TDE"
HOMEPAGE="https://trinitydesktop.org/"

LICENSE="|| ( GPL-2 GPL-3 )"
SLOT="14"
IUSE="cisco libreswan +openvpn pptpd smartcard strongswan"

# Other VPN clients will be added by request, controlled over USE.
#		 If you miss any, please let us know!

DEPEND="
	dev-libs/libgcrypt
	sys-apps/net-tools"
RDEPEND="${DEPEND}
	cisco? ( net-vpn/vpnc )
	libreswan? ( net-vpn/libreswan )
	openvpn? ( net-vpn/openvpn )
	pptpd? ( net-vpn/pptpd )
	smartcard? ( dev-libs/openct )
	strongswan? ( net-vpn/strongswan )"

src_configure() {
	local mycmakeargs=(
		-DBUILD_TRANSLATIONS=ON
	)

	trinity-base-2_src_configure
}
