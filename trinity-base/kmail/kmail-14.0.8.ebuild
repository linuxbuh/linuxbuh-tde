# Copyright 2020 The Trinity Desktop Project
# Distributed under the terms of the GNU General Public License v2

EAPI="7"
TRINITY_MODULE_NAME="tdepim"

inherit trinity-meta-2

DESCRIPTION="The email client for Trinity"
KEYWORDS="~amd64 ~x86"

IUSE="crypt imap mbox sasl"

# The magic of KMail, is fully done by individual TDEIOSlaves,
# so we trigger them to be build, depending on USE flags.

COMMON_DEPEND="
	~trinity-base/libtdepim-${PV}
	~trinity-base/mimelib-${PV}
	~trinity-base/libtdenetwork-${PV}
	~trinity-base/ktnef-${PV}
	~trinity-base/libkcal-${PV}
	~trinity-base/libkmime-${PV}
	~trinity-base/libkpgp-${PV}
	~trinity-base/certmanager-${PV}
	~trinity-base/libkpimidentities-${PV}
	~trinity-base/libksieve-${PV}"

DEPEND="${COMMON_DEPEND}"
RDEPEND="${COMMON_DEPEND}
	crypt? ( app-crypt/pinentry )
	~trinity-base/tdebase-tdeioslaves-${PV}
	mbox? ( ~trinity-base/tdepim-tdeioslaves-${PV} )
	imap? ( ~trinity-base/tdepim-tdeioslaves-${PV}[sasl=] )"

TSM_EXTRACT_ALSO="
	ktnef/
	libemailfunctions/
	mimelib/
	libtdenetwork/
	certmanager/lib/
	libtdepim/
	korganizer/korganizerinterface.h
	korganizer/kcalendarinterface.h
	korganizer/kcalendariface.h
	korganizer/korganizeriface.h
	libkpgp/
	libkmime/
	libksieve/
	libkpimidentities/
	kmail/"

pkg_postinst () {
	if use crypt; then
		elog "Remember that you can build Pinentry with TQt support."
		elog "To do so, just emerge app-crypt/pinentry with \"tqt\" USE"
		elog "and use \"eselect pinentry set pinentry-tqt\" to use it."
	fi
}