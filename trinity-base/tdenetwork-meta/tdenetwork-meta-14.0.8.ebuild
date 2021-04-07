# Copyright 1999-2017 Gentoo Foundation
# Copyright 2020 The Trinity Desktop Project
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

inherit trinity-functions-2

set-trinityver

DESCRIPTION="tdenetwork metapackage - merge this to pull in all tdenetwork-derived packages"
KEYWORDS="~amd64 ~x86"
HOMEPAGE="http://www.trinitydesktop.org/"
LICENSE="|| ( GPL-2 GPL-3 )"

SLOT="${TRINITY_VER}"

RDEPEND="
	~trinity-base/dcoprss-${PV}
	~trinity-base/kdict-${PV}
	~trinity-base/tdednssd-${PV}
	~trinity-base/kget-${PV}
	~trinity-base/knewsticker-${PV}
	~trinity-base/kopete-${PV}
	~trinity-base/kpf-${PV}
	~trinity-base/kppp-${PV}
	~trinity-base/krdc-${PV}
	~trinity-base/krfb-${PV}
	~trinity-base/ksirc-${PV}
	~trinity-base/ktalkd-${PV}
	~trinity-base/kwifimanager-${PV}
	~trinity-base/librss-${PV}
	~trinity-base/lisa-${PV}
	~trinity-base/tdenetwork-doc-${PV}
	~trinity-base/tdenetwork-filesharing-${PV}
	~trinity-base/tdenetwork-tdefile-plugins-${PV}"
