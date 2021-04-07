# Copyright 2020 The Trinity Desktop Project
# Distributed under the terms of the GNU General Public License v2

EAPI="7"
TRINITY_MODULE_NAME="tdemultimedia"

inherit trinity-meta-2

TSM_EXTRACT="tdeioslave"
TRINITY_SUBMODULE="tdeioslave"

DESCRIPTION="Multimedia Trinity TDEIOslaves"
KEYWORDS="~amd64 ~x86"

IUSE="flac"

#Won't build and install if the cd ioslave is not selected, so
#there's no point in keeping this USE flag at the moment.
# cdparanoia

DEPEND="media-sound/cdparanoia
	flac? ( media-libs/flac )"
RDEPEND="${DEPEND}"

TSM_EXTRACT_ALSO="libkcddb/ kscd/"

src_configure() {
	mycmakeargs=(
		-DWITH_FLAC=$(usex flac)
		-DWITH_CDPARANOIA=yes
		-DBUILD_LIBKCDDB=yes
		-DBUILD_KSCD=yes
	)

	trinity-meta-2_src_configure
}

src_install() {
	trinity-meta-2_src_install

	#Junk all the files that overlap with libkcddb and kscd.
	#It would be cleaner not to let them install at all, but I wasn't
	#able to pull that off.
	rm -r ${D}/usr/trinity/14/share/apps/tdeconf_update/kcmcddb-emailsettings.upd
	rm -r ${D}/usr/trinity/14/share/config.kcfg/libkcddb.kcfg
	rm -r ${D}/usr/trinity/14/share/applications/tde/libkcddb.desktop
	rm -r ${D}/usr/trinity/14/include/libkcddb/
	rm -r ${D}/usr/trinity/14/lib64/libkcddb*
	rm -r ${D}/usr/trinity/14/lib64/trinity/kcm_cddb*
	rm -r ${D}/usr/trinity/14/lib64/libkcddb*
	rm -r ${D}/usr/trinity/14/bin/
	rm -r ${D}/usr/trinity/14/share/applications/tde/kscd.desktop
	rm -r ${D}/usr/trinity/14/share/icons/
	rm -r ${D}/usr/trinity/14/share/config.kcfg/kscd.kcfg
	rm -r ${D}/usr/trinity/14/share/apps/profiles/
	rm -r ${D}/usr/trinity/14/share/apps/konqueror/
	rm -r ${D}/usr/trinity/14/share/apps/kscd/
	rm -r ${D}/usr/trinity/14/share/mimelnk/
}