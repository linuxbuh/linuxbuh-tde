# Copyright 1999-2020 Gentoo Authors
# Copyright 2020 The Trinity Desktop Project
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

inherit trinity-functions-2

set-trinityver

DESCRIPTION="tdeutils metapackage - merge this to pull in all tdeutils-derived packages"
HOMEPAGE="https://trinitydesktop.org/"

LICENSE="|| ( GPL-2 GPL-3 )"
KEYWORDS="~amd64 ~x86"
SLOT="${TRINITY_VER}"

RDEPEND="
	~trinity-base/ark-${PV}
	~trinity-base/kcalc-${PV}
	~trinity-base/kcharselect-${PV}
	~trinity-base/kdf-${PV}
	~trinity-base/kedit-${PV}
	~trinity-base/kfloppy-${PV}
	~trinity-base/kgpg-${PV}
	~trinity-base/khexedit-${PV}
	~trinity-base/kjots-${PV}
	~trinity-base/klaptopdaemon-${PV}
	~trinity-base/kmilo-${PV}
	~trinity-base/kregexpeditor-${PV}
	~trinity-base/ksim-${PV}
	~trinity-base/ktimer-${PV}
	~trinity-base/superkaramba-${PV}
	~trinity-base/tdelirc-${PV}
	~trinity-base/tdeutils-doc-${PV}
	~trinity-base/tdewallet-${PV}"

#fails to emerge (no install target)
#	~trinity-base/tdefilereplace-${PV}
