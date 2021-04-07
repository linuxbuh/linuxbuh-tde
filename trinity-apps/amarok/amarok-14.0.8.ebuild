# Copyright 2020 The Trinity Desktop Project
# Distributed under the terms of the GNU General Public License v2

EAPI="7"
TRINITY_MODULE_TYPE="applications"

TRINITY_EXTRAGEAR_PACKAGING="yes"
TRINITY_HANDBOOK="optional"

TRINITY_LANGS="af ar az be bg bn br ca cs cy da de el en_GB eo es
	et eu fa fi fr ga gl he hi hu id is it ja ka km ko ku lo lt mk
	ms nb nds ne nl nn pa pl pt pt_BR ro ru rw se sk sl sq sr sr@Latn
	ss sv ta tg th tr uk uz uz@cyrillic zh_CN zh_TW"

TRINITY_DOC_LANGS="da de es et fr it nl pl pt pt_BR ru sv"

inherit trinity-base-2

DESCRIPTION="Advanced music player for TDE."
KEYWORDS="~amd64 ~x86"
HOMEPAGE="http://trinitydesktop.org/"
LICENSE="|| ( GPL-2 GPL-3 )"

need-trinity

SLOT="${TRINITY_VER}"

# Notes about the ebuild:
#
# - This version supports three engines: Xine, Yauap, and Akode.
#   The only ones supported at the moment are Xine and Akode.
#   Yauap isn't in Portage tree, but could be added later.
#
# - Rio Karma support needs libkarma which neeeds to be added to our overlay later.
#	USE=riokarma 
# 	DEPEND+="	riokarma? ( media-libs/libkarma )"
#		-DWITH_RIOKARMA="$(usex riokarma)"
#
# - No Support for DAAP because it's not tested if that works with Mongrel2.
#
# - As of January 2020, building with anything newer than xine-lib-1.2.9 will fail.
#
# - Otherwise the ebuild should offer all what can be done with CMake at the moment.

IUSE+=" konqsidebar +xine ipod ifp njb mtp mp4
	inotify visualization amazon mysql postgres opengl akode"

REQUIRED_USE="|| ( xine akode )"

DEPEND+="
	dev-lang/ruby:*
	media-libs/taglib
	dev-db/sqlite
	xine? ( <media-libs/xine-lib-1.2.10 )
	akode? ( ~media-libs/akode-${PV} )
	mp4? ( media-libs/libmp4v2 )
	ipod? ( media-libs/libgpod )
	ifp? ( media-libs/libifp )
	njb? ( media-libs/libnjb )
	opengl? ( virtual/opengl )
	postgres? ( dev-db/postgresql )
	mtp? ( media-libs/libmtp )
	mysql? ( virtual/mysql )
	visualization? (
		media-libs/libsdl
		media-plugins/libvisual-plugins
	)
"
RDEPEND+=" ${DEPEND}"

src_configure() {
	mycmakeargs=(
		-DWITH_AMAZON="$(usex amazon)"
		-DWITH_KONQSIDEBAR="$(usex konqsidebar)"
		-DWITH_XINE="$(usex xine)"
		-DWITH_AKODE="$(usex akode)"
		-DWITH_IPOD="$(usex ipod)"
		-DWITH_IFP="$(usex ifp)"
		-DWITH_NJB="$(usex njb)"
		-DWITH_MTP="$(usex mtp)"
		-DWITH_MP4V2="$(usex mp4)"
		-DWITH_INOTIFY="$(usex inotify)"
		-DWITH_OPENGL="$(usex opengl)"
		-DWITH_LIBVISUAL="$(usex visualization)"
		-DWITH_MYSQL="$(usex mysql)"
		-DWITH_POSTGRESQL="$(usex postgres)"
		-DWITH_SYSTEM_SQLITE=ON
		-DWITH_YAUAP=OFF
		-DWITH_DAAP=OFF
	)

	trinity-base-2_src_configure
}
