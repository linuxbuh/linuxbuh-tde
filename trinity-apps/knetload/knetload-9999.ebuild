# Copyright 2020 Gentoo Authors
# Copyright 2020 The Trinity Desktop Project
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

TRINITY_EXTRAGEAR_PACKAGING="yes"
TRINITY_HANDBOOK="optional"

TRINITY_LANGS="ar bs ca cs da de en_GB es et fr is it ja nb nl pt pt_BR
	ro sr sv ta tr zh_CN zh_TW"

TRINITY_MODULE_TYPE="applications"
inherit trinity-base-2

DESCRIPTION="A network meter for Kicker"
HOMEPAGE="https://trinitydesktop.org/"

LICENSE="|| ( GPL-2 GPL-3 )"
SLOT="14"
