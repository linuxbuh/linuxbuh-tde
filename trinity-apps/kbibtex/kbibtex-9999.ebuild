# Copyright 1999-2020 Gentoo Authors
# Copyright 2020 The Trinity Desktop Project
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

TRINITY_EXTRAGEAR_PACKAGING="yes"
TRINITY_HANDBOOK="optional"

TRINITY_LANGS="de fr it pl ru"
TRINITY_MODULE_TYPE="applications"
inherit trinity-base-2

DESCRIPTION="Bibliography editor for TDE"
HOMEPAGE="https://trinitydesktop.org/"

LICENSE="|| ( GPL-2 GPL-3 )"
SLOT="14"

DEPEND="
	dev-libs/libxslt
	dev-libs/yaz
	virtual/tex-base"
RDEPEND="${DEPEND}
	dev-tex/bibtex2html
	dev-tex/latex2rtf
"

src_configure() {
	local mycmakeargs=(
		-DBUILD_TRANSLATIONS=ON
	)

	trinity-base-2_src_configure
}
