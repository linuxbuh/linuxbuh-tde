# Copyright 2020 The Trinity Desktop Project
# Distributed under the terms of the GNU General Public License v2

EAPI="7"
TRINITY_MODULE_TYPE="applications"

TRINITY_EXTRAGEAR_PACKAGING="yes"
TRINITY_HANDBOOK="optional"

TRINITY_LANGS="bg ca da de es fr hu it ja nl pl pt_BR ru sk sv tr zh_CN"

inherit trinity-base-2

DESCRIPTION="VPN clients frontend for TDE"
KEYWORDS="~amd64 ~x86"
HOMEPAGE="http://trinitydesktop.org/"
LICENSE="|| ( GPL-2 GPL-3 )"

need-trinity

SLOT="${TRINITY_VER}"

IUSE+=" cisco smartcard +openvpn strongswan pptpd libreswan"

# Other VPN clients will be added by request, controlled over USE.
#		 If you miss any, please let us know! 

DEPEND+=" sys-apps/net-tools
	dev-libs/libgcrypt"
RDEPEND+=" ${DEPEND}
	cisco? ( net-vpn/vpnc )
	smartcard? ( dev-libs/openct )
	openvpn? ( net-vpn/openvpn )
	strongswan? ( net-vpn/strongswan )
	libreswan? ( net-vpn/libreswan )
	pptpd? ( net-vpn/pptpd )"

src_configure() {
	mycmakeargs=(
		-DBUILD_TRANSLATIONS=ON
	)

	trinity-base-2_src_configure
}
