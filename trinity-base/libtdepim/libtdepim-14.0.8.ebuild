# Copyright 1999-2016 Gentoo Foundation
# Copyright 2020 The Trinity Desktop Project
# Distributed under the terms of the GNU General Public License v2

EAPI="7"
TRINITY_MODULE_NAME="tdepim"

inherit trinity-meta-2

DESCRIPTION="Common library for Trinity PIM applications."
KEYWORDS="~amd64 ~x86"

COMMON_DEPEND="
	~trinity-base/ktnef-${PV}
	~trinity-base/libkmime-${PV}
	~trinity-base/libkcal-${PV}"
DEPEND+=" ${COMMON_DEPEND}"
RDEPEND+=" ${COMMON_DEPEND}"

TSM_EXTRACT_ALSO="libemailfunctions/
	pixmaps/
	libkmime/kmime_util.h
	libkcal/"

src_prepare() {
	trinity-meta-2_src_prepare
	# Call TQt designer
	sed -i -e "s:\"designer\":\"${TQTDIR}/bin/designer\":g" "${S}/libtdepim/kcmdesignerfields.cpp" || die "sed failed"
}
