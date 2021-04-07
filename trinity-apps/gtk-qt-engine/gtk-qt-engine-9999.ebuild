# Copyright 2020 Gentoo Authors
# Copyright 2020 The Trinity Desktop Project
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

TRINITY_EXTRAGEAR_PACKAGING="yes"
TRINITY_HANDBOOK="optional"

TRINITY_LANGS="bg de es fr it nl nn ru sv tr"

TRINITY_MODULE_TYPE="applications"
inherit trinity-base-2

DESCRIPTION="Theme engine using TQt for GTK+2"
HOMEPAGE="https://trinitydesktop.org/"

LICENSE="|| ( GPL-2 GPL-3 )"
SLOT="14"

RDEPEND="x11-libs/gtk+:2"
