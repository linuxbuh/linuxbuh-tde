# Copyright 1999-2020 Gentoo Authors
# Copyright 2020 The Trinity Desktop Project
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

DESCRIPTION="tdeartwork meta package - merge this to pull in all tdeartwork-derived packages"
HOMEPAGE="https://trinitydesktop.org/"

LICENSE="metapackage"
SLOT="14"

RDEPEND="
	~trinity-base/tdeartwork-emoticons-${PV}
	~trinity-base/tdeartwork-icewm-themes-${PV}
	~trinity-base/tdeartwork-icon-themes-${PV}
	~trinity-base/tdeartwork-kworldclock-${PV}
	~trinity-base/tdeartwork-sounds-${PV}
	~trinity-base/tdeartwork-styles-${PV}
	~trinity-base/tdeartwork-tdescreensaver-${PV}
	~trinity-base/tdeartwork-twin-styles-${PV}
	~trinity-base/tdeartwork-wallpapers-${PV}
"
