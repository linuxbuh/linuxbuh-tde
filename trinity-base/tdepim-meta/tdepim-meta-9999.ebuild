# Copyright 1999-2020 Gentoo Authors
# Copyright 2020 The Trinity Desktop Project
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

DESCRIPTION="Tdepim - merge this to pull in all tdepim-derived packages"
HOMEPAGE="https://trinitydesktop.org/"

LICENSE="metapackage"
SLOT="14"

if [[ ${PV} != *9999* ]] ; then
	KEYWORDS="~amd64 ~x86"
fi

RDEPEND="~trinity-base/akregator-${PV}
	~trinity-base/certmanager-${PV}
	~trinity-base/kaddressbook-${PV}
	~trinity-base/kalarm-${PV}
	~trinity-base/karm-${PV}
	~trinity-base/kgantt-${PV}
	~trinity-base/kmail-${PV}
	~trinity-base/kmailcvt-${PV}
	~trinity-base/knode-${PV}
	~trinity-base/knotes-${PV}
	~trinity-base/kode-${PV}
	~trinity-base/kontact-${PV}
	~trinity-base/korganizer-${PV}
	~trinity-base/ktnef-${PV}
	~trinity-base/libkcal-${PV}
	~trinity-base/libkholidays-${PV}
	~trinity-base/libkmime-${PV}
	~trinity-base/libkpimexchange-${PV}
	~trinity-base/libkpimexchange-${PV}
	~trinity-base/libkpimidentities-${PV}
	~trinity-base/libksieve-${PV}
	~trinity-base/libtdenetwork-${PV}
	~trinity-base/libtdepim-${PV}
	~trinity-base/mimelib-${PV}
	~trinity-base/tdepim-doc-${PV}
	~trinity-base/tdepim-tdeioslaves-${PV}
	~trinity-base/tdepim-tderesources-${PV}
	~trinity-base/tdepim-wizards-${PV}
"

#no ebuilds available as of December 2020
#	~trinity-base/kandy-${PV}
#	~trinity-base/kitchensync-${PV}
#	~trinity-base/kmobile-${PV}
#	~trinity-base/konsolekalendar-${PV}
#	~trinity-base/korn-${PV}
#	~trinity-base/libemailfunctions-${PV}
#	~trinity-base/tdeabc-${PV}
