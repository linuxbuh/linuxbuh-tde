# Copyright 1999-2017 Gentoo Foundation
# Copyright 2020 The Trinity Desktop Project
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

inherit trinity-functions-2

set-trinityver
DESCRIPTION="tdemultimedia - merge this to pull in all tdemultimedia-derived packages"
KEYWORDS="~amd64 ~x86"
HOMEPAGE="http://www.trinitydesktop.org/"
LICENSE="|| ( GPL-2 GPL-3 )"

SLOT="${TRINITY_VER}"
IUSE="arts"

#Some packages use hacky workarounds to make up for not being able to
#install only a subset of files.
RDEPEND="arts? ( ~trinity-base/juk-${PV}
		~trinity-base/kaboodle-${PV}
		~trinity-base/tdemultimedia-arts-${PV} )
	~trinity-base/kaudiocreator-${PV}
	~trinity-base/kmix-${PV}
	~trinity-base/krec-${PV}
	~trinity-base/kscd-${PV}
	~trinity-base/libkcddb-${PV}
	~trinity-base/noatun-${PV}
	~trinity-base/tdemid-${PV}
	~trinity-base/tdemultimedia-kappfinder-data-${PV}
	~trinity-base/tdemultimedia-doc-${PV}
	~trinity-base/tdemultimedia-tdeioslaves-${PV}
	~trinity-base/tdemultimedia-tdefile-plugins-${PV}"
