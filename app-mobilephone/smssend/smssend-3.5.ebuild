# Copyright 1999-2020 Gentoo Authors
# Copyright 2020 The Trinity Desktop Project
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

inherit autotools

DESCRIPTION="Universal SMS sender"
HOMEPAGE="https://wiki.gentoo.org/wiki/No_homepage"
SRC_URI="https://mirror.amdmi3.ru/distfiles/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ppc ppc64 sparc x86"

# Don't use Gentoo mirrors
RESTRICT="mirror"

# Without SSL support in skyutils, some providers fail.
DEPEND="dev-libs/skyutils[ssl]"
RDEPEND="${DEPEND}"

PATCHES=( "${FILESDIR}/${P}-verizon.patch" )

S="${WORKDIR}/${PN}"

src_prepare() {
	default

	mv "${S}"/configure.in "${S}"/configure.ac || die
	sed -i 's/AM_CONFIG_HEADER/AC_CONFIG_HEADERS/g' configure.ac \
		|| die 'failed to rename AM_CONFIG_HEADER macro'

	eautoreconf
}
