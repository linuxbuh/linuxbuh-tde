# Copyright 1999-2020 Gentoo Authors
# Copyright 2020 The Trinity Desktop Project
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

DESCRIPTION="tdebase metapackage - merge this to pull in all tdebase-derived packages"
HOMEPAGE="https://trinitydesktop.org/"

LICENSE="metapackage"
SLOT="14"

RDEPEND="
	~trinity-base/drkonqi-${PV}
	~trinity-base/kappfinder-${PV}
	~trinity-base/kate-${PV}
	~trinity-base/kcheckpass-${PV}
	~trinity-base/kcminit-${PV}
	~trinity-base/kcontrol-${PV}
	~trinity-base/kdcop-${PV}
	~trinity-base/kdesktop-${PV}
	~trinity-base/kdialog-${PV}
	~trinity-base/kfind-${PV}
	~trinity-base/khelpcenter-${PV}
	~trinity-base/khotkeys-${PV}
	~trinity-base/kicker-${PV}
	~trinity-base/klipper-${PV}
	~trinity-base/kmenuedit-${PV}
	~trinity-base/knetattach-${PV}
	~trinity-base/konqueror-${PV}
	~trinity-base/konsole-${PV}
	~trinity-base/kpager-${PV}
	~trinity-base/kpersonalizer-${PV}
	~trinity-base/kreadconfig-${PV}
	~trinity-base/krootbacking-${PV}
	~trinity-base/ksmserver-${PV}
	~trinity-base/ksplashml-${PV}
	~trinity-base/kstart-${PV}
	~trinity-base/ksysguard-${PV}
	~trinity-base/ksystraycmd-${PV}
	~trinity-base/ktip-${PV}
	~trinity-base/kxkb-${PV}
	~trinity-base/libkonq-${PV}
	~trinity-base/nsplugins-${PV}
	~trinity-base/tdebase-data-${PV}
	~trinity-base/tdebase-starttde-${PV}
	~trinity-base/tdebase-tdeioslaves-${PV}
	~trinity-base/tdedebugdialog-${PV}
	~trinity-base/tdeeject-${PV}
	~trinity-base/tdeinit-${PV}
	~trinity-base/tdepasswd-${PV}
	~trinity-base/tdeprint-${PV}
	~trinity-base/tdescreensaver-${PV}
	~trinity-base/tdesu-${PV}
	~trinity-base/tdm-${PV}
	~trinity-base/tqt3integration-${PV}
	~trinity-base/twin-${PV}
"
