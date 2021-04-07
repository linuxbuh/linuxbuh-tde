# Copyright 1999-2020 Gentoo Authors
# Copyright 2020 The Trinity Desktop Project
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

TRINITY_MODULE_NAME="tdeutils"
inherit trinity-meta-2

DESCRIPTION="A tool to create interactive applets for the Trinity desktop"

#FIXME: add xmms use
IUSE=""

# RDEPEND="xmms? (media-sound/xmms2)"

src_configure() {
	local mycmakeargs=(
#		-DWITH_XMMS="$(usex xmms)"
#		$(cmake-utils_use_with xmms XMMS )
		-DWITH_KNEWSTUFF=ON
	)
	trinity-meta-2_src_configure
}
