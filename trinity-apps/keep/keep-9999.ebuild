# Copyright 2020 Gentoo Authors
# Copyright 2020 The Trinity Desktop Project
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

TRINITY_EXTRAGEAR_PACKAGING="yes"
TRINITY_HANDBOOK="optional"

TRINITY_LANGS="bg br cs da de el es ga gl it ja
		ka lt nl pl pt ru sk sr sr@Latn sv tr"

TRINITY_MODULE_TYPE="applications"
inherit trinity-base-2

DESCRIPTION="A simple backup system for TDE."
HOMEPAGE="https://trinitydesktop.org/"

LICENSE="|| ( GPL-2 GPL-3 )"
SLOT="14"

RDEPEND="~trinity-base/kcontrol-${PV}
	app-backup/rdiff-backup"

pkg_postinst () {
	echo
	einfo "After initial install the Keep daemon needs to be started via KControl."
	einfo "The Keep daemon will be loaded automatically at the next TDE startup."
	echo
}
