# Copyright 1999-2020 Gentoo Authors
# Copyright 2020 The Trinity Desktop Project
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

TRINITY_MODULE_NAME="tdewebdev"
TRINITY_BUILD_ADMIN="yes"

inherit flag-o-matic trinity-meta-2

DESCRIPTION="Visual dialog builder and executor tool [Trinity]"
HOMEPAGE="https://trinitydesktop.org/"

SLOT="${TRINITY_VER}"
if [[ ${PV} != *9999* ]] ; then
	KEYWORDS="~amd64 ~x86"
fi
IUSE=""

src_configure() {
	append-cxxflags "-std=c++11"
	trinity-meta-2_src_configure
}
