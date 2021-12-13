# Copyright 1999-2019 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$
EAPI="7"

inherit eutils


DESCRIPTION="tdebase minimal package - merge this to pull in all tdebase-derived packages"
HOMEPAGE="http://www.trinitydesktop.org/"
LICENSE="GPL-2"

SLOT="0"
IUSE=""
KEYWORDS="~arm ~arm64 ~x86 ~amd64"

RDEPEND="~trinity-base/tdebase-${PV}
	~trinity-base/tde-i18n-${PV}
"

S=${WORKDIR}

src_install() {
	dodir /usr/share/xsessions
	insinto /usr/share/xsessions
	doins ${FILESDIR}/Trinity.desktop
}
