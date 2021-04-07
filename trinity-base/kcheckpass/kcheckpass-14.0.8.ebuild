# Copyright 1999-2020 Gentoo Authors
# Copyright 2020 The Trinity Desktop Project
# Distributed under the terms of the GNU General Public License v2

EAPI="7"
TRINITY_MODULE_NAME="tdebase"

inherit trinity-meta-2

DESCRIPTION="A simple password checker, used by any software in need of user authentication."
KEYWORDS="~amd64 ~x86"
IUSE="pam"

RDEPEND="pam? ( trinity-base/tdebase-pam )"
DEPEND="${RDEPEND}"

src_configure() {
	mycmakeargs=(
		-DWITH_SHADOW=ON
		-DWITH_PAM="$(usex pam)"
		-DKCHECKPASS_PAM_SERVICE=tde
	)

	trinity-meta-2_src_configure
}
