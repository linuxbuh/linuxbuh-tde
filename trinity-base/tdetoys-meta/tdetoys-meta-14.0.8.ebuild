# Copyright 1999-2017 Gentoo Foundation
# Copyright 2020 The Trinity Desktop Project
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

inherit trinity-functions-2

set-trinityver

DESCRIPTION="tdetoys metapackage - merge this to pull in all tdetoys-derived packages"
KEYWORDS="~amd64 ~x86"
HOMEPAGE="http://www.trinitydesktop.org/"
LICENSE="|| ( GPL-2 GPL-3 )"

SLOT="${TRINITY_VER}"

RDEPEND="
	~trinity-base/amor-${PV}
	~trinity-base/eyesapplet-${PV}
	~trinity-base/fifteenapplet-${PV}
	~trinity-base/tdetoys-doc-${PV}
	~trinity-base/kmoon-${PV}
	~trinity-base/kodo-${PV}
	~trinity-base/kteatime-${PV}
	~trinity-base/ktux-${PV}
	~trinity-base/kweather-${PV}
	~trinity-base/kworldclock-${PV}"
