# Copyright 1999-2020 Gentoo Authors
# Copyright 2020 The Trinity Desktop Project
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

TEG_PO_DIR=${S}

TRINITY_LANGS="ar br cy el et fo he is ka ms nl pl ro sk sv th ve zh_CN
	az ca da en_GB fa fr hi it ko nb nso pt ru sr ta tr vi zh_TW
	bg cs de es fi gl hu ja lt nds pa pt_BR rw sr@Latn uk xh zu"

TRINITY_EXTRAGEAR_PACKAGING="yes"
TRINITY_MODULE_TYPE="applications"
inherit trinity-base-2

DESCRIPTION="Internationalization support for Gwenview [Trinity]"
HOMEPAGE="https://trinitydesktop.org/"

LICENSE="FDL-1.2"
SLOT="14"
if [[ ${PV} != *9999* ]] ; then
	KEYWORDS="~amd64 ~x86"
fi
for X in ${TRINITY_LANGS} ; do
	IUSE="${IUSE} l10n_${X}"
done

DEPEND="
	~trinity-base/tdelibs-${PV}
"
RDEPEND="${DEPEND}"

src_configure() {
	local mycmakeargs=(
		-DBUILD_TRANSLATIONS=ON
	)
	trinity-base-2_src_configure
}
