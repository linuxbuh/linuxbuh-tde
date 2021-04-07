# Copyright 1999-2020 Gentoo Authors
# Copyright 2020 The Trinity Desktop Project
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

TRINITY_EXTRAGEAR_PACKAGING="yes"
TRINITY_HANDBOOK="optional"

TRINITY_LANGS="ar bg br ca cs de el es et fr ga
gl hu it ja nb nl pl pt pt_BR ru sk sv tr uk"
TRINITY_MODULE_TYPE="applications"
inherit trinity-base-2

DESCRIPTION="A general purpose launcher for TDE"
HOMEPAGE="https://trinitydesktop.org/"

LICENSE="|| ( GPL-2 GPL-3 )"
SLOT="14"
