# Copyright 1999-2020 Gentoo Authors
# Copyright 2020 The Trinity Desktop Project
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

TRINITY_EXTRAGEAR_PACKAGING="yes"
TRINITY_HANDBOOK="optional"

TRINITY_LANGS="ca cs de es fr gl it ja lt nl pa ru sv"
TRINITY_MODULE_TYPE="applications"
inherit trinity-base-2

DESCRIPTION="Subversion client with tight TDE integration"
HOMEPAGE="https://trinitydesktop.org/"

LICENSE="|| ( GPL-2 GPL-3 )"
SLOT="14"
IUSE="test"

RESTRICT+=" !test? ( test )"

DEPEND="dev-vcs/subversion"
RDEPEND="${DEPEND}"

src_configure() {
	local mycmakeargs=(
		-DBUILD_TESTS="$(usex test)"
	)
	trinity-base-2_src_configure
}
