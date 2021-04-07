# Copyright 1999-2016 Gentoo Foundation
# Copyright 2020 The Trinity Desktop Project
# Distributed under the terms of the GNU General Public License v2

EAPI="7"
TRINITY_MODULE_NAME="tdepim"

inherit trinity-meta-2

DESCRIPTION="The Trinity Address Book"
KEYWORDS="~amd64 ~x86"
IUSE+=" gnokii"

COMMON_DEPEND="~trinity-base/libtdepim-${PV}
	~trinity-base/libkcal-${PV}
	~trinity-base/certmanager-${PV}
	~trinity-base/libtdenetwork-${PV}
	gnokii? ( app-mobilephone/gnokii )"

DEPEND+=" ${COMMON_DEPEND}"
RDEPEND+=" ${COMMON_DEPEND}"

TSM_EXTRACT_ALSO="certmanager/lib/
	libtdepim/
	libtdenetwork/
	libkcal/
	libemailfunctions/"

src_configure () {
	mycmakeargs=(
		-DWITH_GNOKII="$(usex gnokii)"
	)
	trinity-meta-2_src_configure
}
