# Copyright 2020 Gentoo Authors
# Copyright 2020 The Trinity Desktop Project
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

TRINITY_MODULE_NAME="tdepim"
TSM_EXTRACT_ALSO="
	ktnef/
	libemailfunctions/
	mimelib/
	libtdenetwork/
	certmanager/lib/
	libtdepim/
	korganizer/kcalendariface.h
	korganizer/korganizeriface.h
	libkpimidentities/
	libkpgp/
	libkmime/
	libksieve/
	kmail/
	translations/"
inherit trinity-meta-2

DESCRIPTION="The email client for Trinity"

if [[ ${PV} != *9999* ]] ; then
	KEYWORDS="~amd64 ~x86"
fi
IUSE="crypt imap mbox sasl"

# The magic of KMail, is fully done by individual TDEIOSlaves,
# so we trigger them to be build, depending on USE flags.

DEPEND="
	~trinity-base/certmanager-${PV}
	~trinity-base/ktnef-${PV}
	~trinity-base/libkcal-${PV}
	~trinity-base/libkmime-${PV}
	~trinity-base/libkpgp-${PV}
	~trinity-base/libkpimidentities-${PV}
	~trinity-base/libksieve-${PV}
	~trinity-base/libtdenetwork-${PV}
	~trinity-base/libtdepim-${PV}
	~trinity-base/mimelib-${PV}
"
RDEPEND="${DEPEND}
	~trinity-base/tdebase-tdeioslaves-${PV}
	crypt? ( app-crypt/pinentry )
	imap? ( ~trinity-base/tdepim-tdeioslaves-${PV}[sasl=] )
	mbox? ( ~trinity-base/tdepim-tdeioslaves-${PV} )
	sasl? ( ~trinity-base/tdebase-tdeioslaves-${PV}[sasl=] )
"

src_install() {
	trinity-meta-2_src_install
	insinto "${TDEDIR}/include/kmail"
	doins "${BUILD_DIR}/kmail"/*.h
}

pkg_postinst () {
	if use crypt; then
		elog "Remember that you can build Pinentry with TQt support."
		elog "To do so, just emerge app-crypt/pinentry with \"tqt\" USE"
		elog "and use \"eselect pinentry set pinentry-tqt\" to use it."
	fi
}
