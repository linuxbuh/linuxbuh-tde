# Copyright 1999-2020 Gentoo Authors
# Copyright 2020 The Trinity Desktop Project
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

TRINITY_MODULE_NAME="tdepim"
TSM_EXTRACT_ALSO="libtdepim/ libtdenetwork/ plugins/ korganizer/ kaddressbook/
	kmail/ knotes/ knode/ akregator/ karm/ libemailfunctions/ libkpimidentities/
	libkholidays/ translations/"
inherit trinity-meta-2

DESCRIPTION="Trinity personal information manager"

if [[ ${PV} != *9999* ]] ; then
	KEYWORDS="~amd64 ~x86"
fi
IUSE="kmail"

DEPEND="
	~trinity-base/libtdepim-${PV}
	~trinity-base/libkpimidentities-${PV}
	~trinity-base/libkholidays-${PV}
	~trinity-base/knotes-${PV}
	~trinity-base/korganizer-${PV}
	kmail? ( ~trinity-base/kmail-${PV} )
"
RDEPEND="${DEPEND}"

src_prepare() {
	if use kmail ; then
		cp "${TDEDIR}/include/kmail"/*.h "${S}/kmail" || die
	else
		sed -i '/kmail/d' kontact/plugins/CMakeLists.txt || die
		sed -i '/specialdates/d' kontact/plugins/CMakeLists.txt || die
	fi
	trinity-meta-2_src_prepare
}
