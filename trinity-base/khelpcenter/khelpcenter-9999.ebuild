# Copyright 1999-2020 Gentoo Authors
# Copyright 2020 The Trinity Desktop Project
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

TRINITY_MODULE_NAME="tdebase"
TRINITY_SUBMODULE="khelpcenter doc"
TSM_EXTRACT_ALSO="translations/"
inherit trinity-meta-2

DESCRIPTION="The Trinity help center"

RDEPEND="
	~trinity-base/tdebase-tdeioslaves-${PV}
	|| (
		www-misc/htdig
		www-misc/hldig
	)
"
