# Copyright 1999-2020 Gentoo Authors
# Copyright 2020 The Trinity Desktop Project
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

DESCRIPTION="Micro Linux distro to boot from CD and play video files localized in CD root"
HOMEPAGE="http://movix.sourceforge.net"
SRC_URI="mirror://sourceforge/movix/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc ppc64 x86"

# Don't use Gentoo mirrors
RESTRICT="mirror"

RDEPEND="virtual/cdrtools"
DEPEND="dev-lang/perl
	virtual/awk"

src_install() {
	emake -j1 DESTDIR="${D}" install
	dodoc AUTHORS ChangeLog README* TODO
	dosym /usr/lib/win32 /usr/share/emovix/codecs
}
