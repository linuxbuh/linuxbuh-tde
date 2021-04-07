# Copyright 1999-2016 Gentoo Foundation
# Copyright 2020 The Trinity Desktop Project
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

inherit trinity-functions-2

set-trinityver

DESCRIPTION="kdepim - merge this to pull in all kdepim-derived packages"
KEYWORDS="~amd64 ~x86"
HOMEPAGE="http://www.trinitydesktop.org/"
LICENSE="|| ( GPL-2 GPL-3 )"

SLOT="${TRINITY_VER}"

RDEPEND="
	~trinity-base/akregator-${PV}
	~trinity-base/certmanager-${PV}
	~trinity-base/kaddressbook-${PV}
	~trinity-base/kgantt-${PV}
	~trinity-base/kmail-${PV}
	~trinity-base/knode-${PV}
	~trinity-base/knotes-${PV}
	~trinity-base/ktnef-${PV}
	~trinity-base/libkcal-${PV}
	~trinity-base/libkholidays-${PV}
	~trinity-base/libkmime-${PV}
	~trinity-base/libkpgp-${PV}
	~trinity-base/libkpimexchange-${PV}
	~trinity-base/libkpimidentities-${PV}
	~trinity-base/libksieve-${PV}
	~trinity-base/libtdenetwork-${PV}
	~trinity-base/libtdepim-${PV}
	~trinity-base/mimelib-${PV}
	~trinity-base/tdepim-tdeioslaves-${PV}"

#won't build without non-existant globalsettings_base.h
#	~trinity-base/korganizer-${PV}
#	~trinity-base/kontact-${PV}

#no ebuilds available as of June 2020
#	~trinity-base/kalarm-${PV}
#	~trinity-base/kandy-${PV}
#	~trinity-base/karm-${PV}
#	~trinity-base/kdgantt-${PV}
#	~trinity-base/kitchensync-${PV}
#	~trinity-base/kmailcvt-${PV}
#	~trinity-base/kmobile-${PV}
#	~trinity-base/kode-${PV}
#	~trinity-base/konsolekalendar-${PV}
#	~trinity-base/korn-${PV}
#	~trinity-base/libemailfunctions-${PV}
#	~trinity-base/tdeabc-${PV}
#	~trinity-base/tdepim-tderesources-${PV}
#	~trinity-base/tdepim-wizards-${PV}
