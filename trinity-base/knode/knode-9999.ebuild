# Copyright 2020 Gentoo Authors
# Copyright 2020 The Trinity Desktop Project
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

TRINITY_MODULE_NAME="tdepim"
TSM_EXTRACT_ALSO="libtdepim/ libemailfunctions/ libkpgp/ libkmime/ translations/"
inherit cmake

SLOT=0

DESCRIPTION="A newsreader for TDE"

if [[ ${PV} != *9999* ]] ; then
	KEYWORDS="~amd64 ~x86"
fi

DEPEND="
	~trinity-base/ktnef-${PV}
	~trinity-base/libkcal-${PV}
	~trinity-base/libkmime-${PV}
	~trinity-base/libtdepim-${PV}
	~trinity-base/libkpgp-${PV}
"
RDEPEND="${DEPEND}"
