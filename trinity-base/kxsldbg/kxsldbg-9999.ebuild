# Copyright 1999-2020 Gentoo Authors
# Copyright 2020 The Trinity Desktop Project
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

TRINITY_MODULE_NAME="tdewebdev"
TRINITY_BUILD_ADMIN="yes"

inherit trinity-meta-2 flag-o-matic

DESCRIPTION="Graphical XSLT debugger for TDE [Trinity]"
HOMEPAGE="https://trinitydesktop.org/"

SLOT="${TRINITY_VER}"
if [[ ${PV} != *9999* ]] ; then
	KEYWORDS="~amd64 ~x86"
fi
IUSE=""

DEPEND="
	dev-libs/libxslt
	dev-libs/libxml2
"

RDEPEND="${DEPEND}"

src_configure() {
	append-cxxflags "-std=c++11"
	trinity-meta-2_src_configure
}
