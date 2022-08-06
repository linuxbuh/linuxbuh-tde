# Copyright 1999-2016 Gentoo Foundation
# Copyright 2020 The Trinity Desktop Project
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

inherit trinity-functions-2

set-trinityver

DESCRIPTION="tdegames metapackage - merge this to pull in all tdegames-derived packages"
KEYWORDS="~amd64 ~x86"
HOMEPAGE="http://www.trinitydesktop.org/"
LICENSE="|| ( GPL-2 GPL-3 )"

SLOT="${TRINITY_VER}"

RDEPEND="
	~trinity-base/atlantik-${PV}
	~trinity-base/kasteroids-${PV}
	~trinity-base/katomic-${PV}
	~trinity-base/kbackgammon-${PV}
	~trinity-base/kbattleship-${PV}
	~trinity-base/kblackbox-${PV}
	~trinity-base/kbounce-${PV}
	~trinity-base/kenolaba-${PV}
	~trinity-base/kfouleggs-${PV}
	~trinity-base/kgoldrunner-${PV}
	~trinity-base/kjumpingcube-${PV}
	~trinity-base/klickety-${PV}
	~trinity-base/klines-${PV}
	~trinity-base/kmahjongg-${PV}
	~trinity-base/kmines-${PV}
	~trinity-base/knetwalk-${PV}
	~trinity-base/kolf-${PV}
	~trinity-base/konquest-${PV}
	~trinity-base/kpat-${PV}
	~trinity-base/kpoker-${PV}
	~trinity-base/kreversi-${PV}
	~trinity-base/ksame-${PV}
	~trinity-base/kshisen-${PV}
	~trinity-base/ksirtet-${PV}
	~trinity-base/ksmiletris-${PV}
	~trinity-base/ksnake-${PV}
	~trinity-base/ksokoban-${PV}
	~trinity-base/kspaceduel-${PV}
	~trinity-base/ktron-${PV}
	~trinity-base/ktuberling-${PV}
	~trinity-base/libtdegames-${PV}
	~trinity-base/lskat-${PV}
	~trinity-base/twin4-${PV}"
