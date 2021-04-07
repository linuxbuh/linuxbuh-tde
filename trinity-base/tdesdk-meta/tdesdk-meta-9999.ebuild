# Copyright 1999-2020 Gentoo Authors
# Copyright 2020 The Trinity Desktop Project
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

DESCRIPTION="Metapackage Trinity Software Development Kit (SDK)"
HOMEPAGE="http://www.trinitydesktop.org/"

LICENSE="metapackage"
SLOT="14"
if [[ ${PV} != *9999* ]] ; then
	KEYWORDS="~amd64 ~x86"
fi
IUSE=""

RDEPEND="
	~trinity-base/cervisia-${PV}
	~trinity-base/kapptemplate-${PV}
	~trinity-base/kbabel-${PV}
	~trinity-base/kbugbuster-${PV}
	~trinity-base/tdecachegrind-${PV}
	~trinity-base/tdesdk-scripts-${PV}
	~trinity-base/kmtrace-${PV}
	~trinity-base/kompare-${PV}
	~trinity-base/kspy-${PV}
	~trinity-base/kuiviewer-${PV}
	~trinity-base/poxml-${PV}
	~trinity-base/umbrello-${PV}
	~trinity-base/tdeunittest-${PV}
	~trinity-base/tdesdk-doc-${PV}"
