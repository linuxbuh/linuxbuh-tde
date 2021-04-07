# Copyright 1999-2020 Gentoo Authors
# Copyright 2020 The Trinity Desktop Project
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

DESCRIPTION="tdegraphics metapackage - merge this to pull in all tdegraphics-derived packages"
HOMEPAGE="https://trinitydesktop.org/"

LICENSE="metapackage"
SLOT="14"

RDEPEND="
	~trinity-base/kamera-${PV}
	~trinity-base/kcoloredit-${PV}
	~trinity-base/kdvi-${PV}
	~trinity-base/kfax-${PV}
	~trinity-base/kgamma-${PV}
	~trinity-base/kghostview-${PV}
	~trinity-base/kmrml-${PV}
	~trinity-base/kolourpaint-${PV}
	~trinity-base/kooka-${PV}
	~trinity-base/kpdf-${PV}
	~trinity-base/kpovmodeler-${PV}
	~trinity-base/kruler-${PV}
	~trinity-base/ksnapshot-${PV}
	~trinity-base/ksvg-${PV}
	~trinity-base/kuickshow-${PV}
	~trinity-base/kview-${PV}
	~trinity-base/kviewshell-${PV}
	~trinity-base/libkscan-${PV}
	~trinity-base/tdegraphics-doc-${PV}
	~trinity-base/tdegraphics-tdefile-plugins-${PV}
	~trinity-base/tdeiconedit-${PV}
"
