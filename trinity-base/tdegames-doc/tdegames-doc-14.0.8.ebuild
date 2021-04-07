# Copyright 1999-2016 Gentoo Foundation
# Copyright 2020 The Trinity Desktop Project
# Distributed under the terms of the GNU General Public License v2

EAPI="7"
TRINITY_MODULE_NAME="tdegames"

inherit trinity-meta-2

DESCRIPTION="Documentaion for tdegames-derived packages"
KEYWORDS="~amd64 ~x86"

RDEPEND="
	~trinity-base/khelpcenter-${PV}"

pkg_setup() {
	# Issue some warning if MAKEOPTS -j parameter is higher than 4
	local makeopts_j
	makeopts_j="$(echo "$MAKEOPTS" | sed -n 's/\(^\|.*\s\)\(-j\s*[0-9]\+\)\(\s.*\|$\)/\2/p')"
	if [ -n "$makeopts_j" -a "$makeopts_j" > 4 ]; then

		ewarn "This ebuild needs huge amoumt of memmory to compile in highly parallel"
		ewarn "mode so it can chew it all. Please change your MAKEOPTS if building fails."
	fi

	trinity-meta-2_pkg_setup
}
