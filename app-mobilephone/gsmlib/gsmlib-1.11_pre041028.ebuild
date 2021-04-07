# Copyright 1999-2020 Gentoo Authors
# Copyright 2020 The Trinity Desktop Project
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

inherit eutils

DESCRIPTION="Library and applications to access GSM mobile phones"
HOMEPAGE="http://www.pxh.de/fs/gsmlib/"
SRC_URI="http://www.pxh.de/fs/gsmlib/snapshots/${PN}-pre${PV%_pre*}-${PV#*_pre}.tar.gz"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="amd64 ~ia64 ppc ppc64 sparc x86"

# Don't use Gentoo mirrors
RESTRICT+=" mirror test"

S="${WORKDIR}/${PN}-${PV%_pre*}"

PATCHES=(
	"${FILESDIR}/${P%_pre*}-include-gcc34-fix.patch"
	"${FILESDIR}/${P%_pre*}-gcc41.patch"
	"${FILESDIR}/${P%_pre*}-gcc43.patch"
)

src_unpack() {
	unpack ${A}
}

src_install () {
	emake DESTDIR="${D}" install || die "make install failed"
	dodoc README
}
