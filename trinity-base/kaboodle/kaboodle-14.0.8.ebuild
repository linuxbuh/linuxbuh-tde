# Copyright 2020 The Trinity Desktop Project
# Distributed under the terms of the GNU General Public License v2

EAPI="7"
TRINITY_MODULE_NAME="tdemultimedia"

inherit trinity-meta-2

DESCRIPTION="The Lean TDE Media Player"
KEYWORDS="~amd64 ~x86"

RDEPEND="~trinity-base/tdemultimedia-arts-${PV}"
