# Copyright 1999-2020 Gentoo Authors
# Copyright 2020 The Trinity Desktop Project
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

TRINITY_MODULE_NAME="tdepim"
TSM_EXTRACT_ALSO="certmanager/lib/
	libtdepim/
	libtdenetwork/
	libkcal/
	libemailfunctions/"
inherit trinity-meta-2

DESCRIPTION="The Trinity Address Book"

IUSE="gnokii"

DEPEND="
	~trinity-base/certmanager-${PV}
	~trinity-base/libkcal-${PV}
	~trinity-base/libtdenetwork-${PV}
	~trinity-base/libtdepim-${PV}
	gnokii? ( app-mobilephone/gnokii )
"
RDEPEND="${DEPEND}"

src_configure() {
	local mycmakeargs=(
		-DWITH_GNOKII="$(usex gnokii)"
	)
	trinity-meta-2_src_configure
}
