# Copyright 2020 Gentoo Authors
# Copyright 2020 The Trinity Desktop Project
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

TRINITY_EXTRAGEAR_PACKAGING="yes"
TRINITY_HANDBOOK="optional"

TRINITY_LANGS="de el es et fr hu it ja nl pl pt pt_BR ru sv tr"

TRINITY_MODULE_TYPE="applications"
inherit trinity-base-2

DESCRIPTION="A Quake-style terminal emulator for TDE"
HOMEPAGE="https://trinitydesktop.org/"

LICENSE="|| ( GPL-2 GPL-3 )"
SLOT="14"

DEPEND="~trinity-base/konsole-${PV}"
RDEPEND="${DEPEND}"
