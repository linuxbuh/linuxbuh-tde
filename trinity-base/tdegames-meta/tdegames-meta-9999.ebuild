# Copyright 1999-2020 Gentoo Authors
# Copyright 2020 The Trinity Desktop Project
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

DESCRIPTION="tdegames metapackage - merge this to pull in all tdegames-derived packages"
HOMEPAGE="https://trinitydesktop.org/"

LICENSE="metapackage"
SLOT="14"

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
	~trinity-base/twin4-${PV}
"
