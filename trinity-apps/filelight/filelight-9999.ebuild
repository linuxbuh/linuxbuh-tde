# Copyright 1999-2020 Gentoo Authors
# Copyright 2020 The Trinity Desktop Project
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

TRINITY_EXTRAGEAR_PACKAGING="yes"
TRINITY_HANDBOOK="optional"

TRINITY_LANGS="az bg br ca cs cy da de el en_GB es
	et fr ga gl is it ja ka lt nb nl pl pt pt_BR
	ro ru rw sr sr@Latn sv ta tr uk"

TRINITY_DOC_LANGS="da es et it pt ru sv"

TRINITY_MODULE_TYPE="applications"
inherit trinity-base-2

DESCRIPTION="Visualise disk usage with interactive map of concentric, segmented rings"
HOMEPAGE="https://trinitydesktop.org/"

LICENSE="|| ( GPL-2 GPL-3 )"
SLOT="14"
