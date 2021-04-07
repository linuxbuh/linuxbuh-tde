# Copyright 1999-2016 Gentoo Foundation
# Copyright 2020 The Trinity Desktop Project
# Distributed under the terms of the GNU General Public License v2

EAPI="7"
TRINITY_MODULE_NAME="tdepim"

inherit trinity-meta-2

DESCRIPTION="Trinity certificate manager gui"
KEYWORDS="~amd64 ~x86"

COMMON_DEPEND="~trinity-base/libtdenetwork-${PV}
	app-crypt/gpgme
	app-crypt/gnupg"
DEPEND+=" ${COMMON_DEPEND}"
RDEPEND+=" ${COMMON_DEPEND}"

TSM_EXTRACT_ALSO="libtdepim/ libkpgp/ libtdenetwork/"

pkg_postinst() {
	trinity-meta-2_pkg_postinst
	elog "For X.509 CRL and OCSP support, install app-crypt/dirmngr, please."
}
