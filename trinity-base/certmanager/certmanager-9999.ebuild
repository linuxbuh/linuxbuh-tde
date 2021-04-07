# Copyright 1999-2020 Gentoo Authors
# Copyright 2020 The Trinity Desktop Project
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

TRINITY_MODULE_NAME="tdepim"
TSM_EXTRACT_ALSO="libtdepim/ libkpgp/ libtdenetwork/"
inherit trinity-meta-2

DESCRIPTION="Trinity certificate manager gui"

if [[ ${PV} != *9999* ]] ; then
	KEYWORDS="~amd64 ~x86"
fi

COMMON_DEPEND="~trinity-base/libtdenetwork-${PV}
	app-crypt/gpgme
	app-crypt/gnupg"
DEPEND="${COMMON_DEPEND}"
RDEPEND="${COMMON_DEPEND}"

pkg_postinst() {
	trinity-meta-2_pkg_postinst
	elog "For X.509 CRL and OCSP support, install app-crypt/dirmngr, please."
}
