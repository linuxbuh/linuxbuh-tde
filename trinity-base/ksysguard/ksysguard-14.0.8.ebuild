# Copyright 1999-2020 Gentoo Authors
# Copyright 2020 The Trinity Desktop Project
# Distributed under the terms of the GNU General Public License v2

EAPI="7"
TRINITY_MODULE_NAME="tdebase"

inherit trinity-meta-2

DESCRIPTION="A network enabled task manager/system monitor"
KEYWORDS="~amd64 ~x86"

IUSE="dell-laptop lm-sensors"

DEPEND="lm-sensors? ( sys-apps/lm-sensors )"
RDEPEND="${DEPEND}"

src_configure() {
	mycmakeargs=(
		-DWITH_I8K="$(usex dell-laptop)"
		-DWITH_SENSORS="$(usex lm-sensors)"
	)

	trinity-meta-2_src_configure
}
