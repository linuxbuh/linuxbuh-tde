# Copyright 1999-2020 Gentoo Authors
# Copyright 2020 The Trinity Desktop Project
# Distributed under the terms of the GNU General Public License v2

EAPI="7"
TRINITY_MODULE_NAME="tdepim"
TRINITY_SUBMODULE="tderesources"

inherit trinity-meta-2

DESCRIPTION="PIM groupware plugin collection for TDE [Trinity]"

if [[ ${PV} != *9999* ]] ; then
	KEYWORDS="~amd64 ~x86"
fi

DEPEND="~trinity-base/kode-${PV}
	~trinity-base/knotes-${PV}"
RDEPEND="${DEPEND}"

TSM_EXTRACT_ALSO="libtdepim/ libkcal/ kaddressbook/ kmail/ knotes/ libemailfunctions/ \
		korganizer/ kode/ translations/"

src_configure() {
	local mycmakeargs=(
		-DWITH_EGROUPWARE=ON
		-DWITH_KOLAB=ON
		-DWITH_SLOX=ON
		-DWITH_GROUPWISE=ON
		-DWITH_NEWEXCHANGE=ON
		-DWITH_SCALIX=ON
		-DWITH_GROUPDAV=ON
		-DWITH_BIRTHDAYS=ON
		-DWITH_FEATUREPLAN=ON
	)
	trinity-meta-2_src_configure
}
