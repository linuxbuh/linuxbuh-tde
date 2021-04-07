# Copyright 1999-2020 Gentoo Authors
# Copyright 2020 The Trinity Desktop Project
# Distributed under the terms of the GNU General Public License v2

EAPI="7"
TRINITY_MODULE_NAME="tdepim"
TRINITY_SUBMODULE="wizards"

inherit trinity-meta-2

DESCRIPTION="TDEPIM wizards"

if [[ ${PV} != *9999* ]] ; then
	KEYWORDS="~amd64 ~x86"
fi

DEPEND="~trinity-base/knotes-${PV}
	~trinity-base/libkcal-${PV}
	~trinity-base/tdepim-tderesources-${PV}"
RDEPEND="${DEPEND}"

TSM_EXTRACT_ALSO="libtdepim/ tderesources/ kmail/ libkpimidentities/ knotes/ libkcal/ \
	libemailfunctions/ translations/"

src_configure() {
	local mycmakeargs=(
		-DCMAKE_CXX_FLAGS="-L${TDEDIR}/$(get_libdir)"
		-DWITH_EGROUPWARE=ON
		-DWITH_KOLAB=ON
		-DWITH_SLOX=ON
		-DWITH_GROUPWISE=ON
		-DWITH_NEWEXCHANGE=ON
		-DWITH_SCALIX=ON
	)
	trinity-meta-2_src_configure
}
