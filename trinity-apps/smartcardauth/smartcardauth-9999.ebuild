# Copyright 2020 Gentoo Authors
# Copyright 2020 The Trinity Desktop Project
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

TRINITY_MODULE_TYPE="applications"
inherit trinity-base-2

DESCRIPTION="SmartCard login and LUKS decrypt"
HOMEPAGE="https://trinitydesktop.org/"

LICENSE="|| ( GPL-2 GPL-3 )"
SLOT="14"
IUSE="libressl"

DEPEND="
	dev-libs/pkcs11-helper
	net-libs/gnutls
	!libressl? ( dev-libs/openssl:= )
	libressl? ( dev-libs/libressl:= )
"
RDEPEND="${DEPEND}"
