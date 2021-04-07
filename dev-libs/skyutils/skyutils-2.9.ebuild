# Copyright 1999-2020 Gentoo Authors
# Copyright 2020 The Trinity Desktop Project
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

inherit flag-o-matic autotools

DESCRIPTION="Library of assorted C utility functions"
HOMEPAGE="https://wiki.gentoo.org/wiki/No_homepage"
SRC_URI="https://mirror.amdmi3.ru/distfiles/${P}.tar.gz"

LICENSE="LGPL-2.1+"
SLOT="0"
KEYWORDS="amd64 ppc ppc64 sparc x86"
IUSE="ssl libressl"

# Don't use Gentoo mirrors
RESTRICT="mirror"

DEPEND="
	ssl? (
		!libressl? ( dev-libs/openssl:= )
		libressl? ( dev-libs/libressl:= )
	)"
RDEPEND="${DEPEND}"

PATCHES=(
	"${FILESDIR}/${P}-libs.patch"
	"${FILESDIR}/fix-Wformat-security-warnings.patch"
	"${FILESDIR}/without-ssl3.patch"
)

S="${WORKDIR}/${PN}"

src_prepare() {
	default
	mv "${S}"/configure.in "${S}"/configure.ac || die
	sed -i 's/AM_CONFIG_HEADER/AC_CONFIG_HEADERS/g' configure.ac \
		|| die 'failed to rename AM_CONFIG_HEADER macro'

	eautoreconf
}

src_configure() {
	append-cppflags -D_GNU_SOURCE
	econf $(use_enable ssl)
}
