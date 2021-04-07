# Copyright 1999-2020 Gentoo Authors
# Copyright 2020 The Trinity Desktop Project
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

TRINITY_MODULE_NAME="tdemultimedia"
inherit trinity-meta-2

DESCRIPTION="Media player featuring audio effects, graphic equalizer and network transparency"
HOMEPAGE="https://trinitydesktop.org/"

KEYWORDS="~amd64 ~x86"

RDEPEND="~trinity-base/tdemultimedia-arts-${PV}"
DEPEND="${RDEPEND}
	x11-libs/libXext
"

TSM_EXTRACT_ALSO="arts mpeglib"

src_configure() {
	local mycmakeargs=(
		-DBUILD_ARTS=ON
		-DBUILD_MPEGLIB=ON
	)

	trinity-meta-2_src_configure
}

src_install() {
	trinity-meta-2_src_install

	#Junk all the files that overlap with tdemultimedia-arts.
	#It would be cleaner not to let them install at all, but I wasn't
	#able to pull that off.
	rm -r "${D}"/usr/trinity/14/share/apps/artscontrol/ || die
	rm -r "${D}"/usr/trinity/14/share/apps/artsbuilder/ || die
	rm -r "${D}"/usr/trinity/14/include/arts/ || die
	rm -r "${D}"/usr/trinity/14/include/mpeglib/ || die
	rm -r "${D}"/usr/trinity/14/lib64/libarts* || die
	rm -r "${D}"/usr/trinity/14/lib64/mcop/arts* || die
	rm -r "${D}"/usr/trinity/14/lib64/mcop/Arts/ || die
	rm -r "${D}"/usr/trinity/14/lib64/libmpeg* || die
	rm -r "${D}"/usr/trinity/14/lib64/libyaf* || die
	rm -r "${D}"/usr/trinity/14/share/icons/*/*/apps/artscontrol.png || die
	rm -r "${D}"/usr/trinity/14/share/icons/*/*/apps/artsbuilder.png || die
	rm -r "${D}"/usr/trinity/14/share/icons/hicolor/scalable/ || die
	rm -r "${D}"/usr/trinity/14/share/icons/crystalsvg/*/actions/arts* || die
	rm -r "${D}"/usr/trinity/14/share/applications/tde/artscontrol.desktop || die
	rm -r "${D}"/usr/trinity/14/share/applications/tde/artsbuilder.desktop || die
	rm -r "${D}"/usr/trinity/14/bin/artscontrol || die
	rm -r "${D}"/usr/trinity/14/bin/artsbuilder || die
	rm -r "${D}"/usr/trinity/14/bin/yaf* || die
	rm -r "${D}"/usr/trinity/14/bin/midisend || die
	rm -r "${D}"/usr/trinity/14/share/mimelnk/application/x-artsbuilder.desktop || die
	rm -r "${D}"/usr/trinity/14/share/apps/kicker/ || die
}

#KMCOMPILEONLY="arts"

#src_compile() {
#	# fix bug 128884
#	filter-flags -fomit-frame-pointer
#	kde-meta_src_compile
#}
