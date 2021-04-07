# Copyright 2020 The Trinity Desktop Project
# Distributed under the terms of the GNU General Public License v2

EAPI="7"
TRINITY_MODULE_TYPE="applications"

TRINITY_EXTRAGEAR_PACKAGING="yes"
TRINITY_HANDBOOK="optional"

TRINITY_LANGS="bg de es fr it nl nn ru sv tr"

inherit trinity-base-2

DESCRIPTION="Theme engine using TQt for GTK+2"
KEYWORDS="~amd64 ~x86"
HOMEPAGE="http://trinitydesktop.org/"
LICENSE="|| ( GPL-2 GPL-3 )"

need-trinity

RDEPEND="x11-libs/gtk+:2"

SLOT="${TRINITY_VER}"
