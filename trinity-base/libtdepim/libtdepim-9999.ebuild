# Copyright 1999-2020 Gentoo Authors
# Copyright 2020 The Trinity Desktop Project
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

TRINITY_MODULE_NAME="tdepim"
TSM_EXTRACT_ALSO="libemailfunctions/
	pixmaps/
	libkmime/kmime_util.h
	libkcal/"
inherit trinity-meta-2

DESCRIPTION="Common library for Trinity PIM applications"

DEPEND="
	~trinity-base/ktnef-${PV}
	~trinity-base/libkcal-${PV}
	~trinity-base/libkmime-${PV}
"
RDEPEND="${DEPEND}"

src_prepare() {
	trinity-meta-2_src_prepare
	# Call TQt designer
	sed -e "s:\"designer\":\"${TQTDIR}/bin/designer\":g" \
		-i "libtdepim/kcmdesignerfields.cpp" || die
}
