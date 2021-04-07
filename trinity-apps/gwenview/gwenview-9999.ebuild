# Copyright 1999-2020 Gentoo Authors
# Copyright 2020 The Trinity Desktop Project
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

TRINITY_BUILD_ADMIN="yes"
TRINITY_MODULE_TYPE="applications"
inherit trinity-base-2

DESCRIPTION="Image viewer for TDE"
HOMEPAGE="https://trinitydesktop.org/"

LICENSE="GPL-2+"
SLOT="14"
if [[ ${PV} != *9999* ]] ; then
	KEYWORDS="~amd64 ~x86"
fi
IUSE=""

DEPEND="
	media-gfx/exiv2
	~trinity-apps/gwenview-i18n-${PV}
	~trinity-base/tdelibs-${PV}
"
RDEPEND="${DEPEND}"
