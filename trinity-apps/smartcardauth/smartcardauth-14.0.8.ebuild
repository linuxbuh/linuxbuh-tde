# Copyright 2020 The Trinity Desktop Project
# Distributed under the terms of the GNU General Public License v2

EAPI="7"
TRINITY_MODULE_TYPE="applications"

inherit trinity-base-2

DESCRIPTION="SmartCard login and LUKS decrypt"
KEYWORDS="~amd64 ~x86"
HOMEPAGE="http://trinitydesktop.org/"
LICENSE="|| ( GPL-2 GPL-3 )"

need-trinity

SLOT="${TRINITY_VER}"

IUSE+=" libressl"

DEPEND+="
	net-libs/gnutls
	dev-libs/pkcs11-helper
	!libressl? ( dev-libs/openssl:= )
	libressl? ( dev-libs/libressl:= )
"
RDEPEND+=" ${DEPEND}"
