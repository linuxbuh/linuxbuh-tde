# Copyright 1999-2020 Gentoo Authors
# Copyright 2020 The Trinity Desktop Project
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

TRINITY_MODULE_NAME="tdewebdev"

inherit flag-o-matic trinity-meta-2

DESCRIPTION="Web development environment for TDE [Trinity]"
HOMEPAGE="https://trinitydesktop.org/"

SRC_URI+="
	http://download.sourceforge.net/quanta/html.tar.bz2
	http://download.sourceforge.net/quanta/css.tar.bz2
	http://download.sourceforge.net/quanta/javascript.tar.bz2
	http://download.sourceforge.net/quanta/php_manual_en_20030401.tar.bz2"

SLOT="${TRINITY_VER}"
if [[ ${PV} != *9999* ]] ; then
	KEYWORDS="~amd64 ~x86"
fi
IUSE=""

DEPEND="
	app-text/htmltidy
	dev-libs/libxml2
	dev-libs/libxslt
	~trinity-base/klinkstatus-${PV}
	~trinity-base/kommander-${PV}
	~trinity-base/tdefilereplace-${PV}
"

RDEPEND="${DEPEND}"

TSM_EXTRACT_ALSO="lib/"

src_unpack() {
	trinity-meta-2_src_unpack
	unpack php_manual_en_20030401.tar.bz2
	cd "${S}"
	unpack css.tar.bz2
	unpack javascript.tar.bz2
	unpack html.tar.bz2
}

src_configure() {
	append-cxxflags "-std=c++11"
	trinity-meta-2_src_configure
}

src_install() {
	dodir ${TDEDIR}/share/apps/quanta/doc

	for i in css html javascript ; do
	pushd $i >/dev/null || die
	./install.sh <<EOF
${D}/${TDEDIR}/share/apps/quanta/doc
EOF
	popd >/dev/null || die
	rm -rf $i || die
	done
	cp -rf "${WORKDIR}/php" "${WORKDIR}/php.docrc" "${D}/${TDEDIR}/share/apps/quanta/doc" || die

	trinity-meta-2_src_install
}
