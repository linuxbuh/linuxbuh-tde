# Copyright 1999-2020 Gentoo Authors
# Copyright 2020 The Trinity Desktop Project
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

inherit autotools

DESCRIPTION="HTTP/HTML indexing and searching system"
HOMEPAGE="https://github.com/solbu/hldig"
SRC_URI="https://github.com/solbu/${PN}/archive/v${PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 arm arm64 ppc ppc64 x86"
IUSE="libressl ssl"

# Don't use Gentoo mirrors
RESTRICT="mirror"

DEPEND="
	app-arch/unzip
	sys-libs/zlib
	ssl? (
		!libressl? ( dev-libs/openssl:0= )
		libressl? ( dev-libs/libressl:0= )
	)
"
RDEPEND="${DEPEND}
	!www-misc/htdig
"

S="${WORKDIR}/${PN}-${PV}"

HTML_DOCS=( docs/. )

src_prepare() {
	default
	sed -e "s/AM_CONFIG_HEADER/AC_CONFIG_HEADERS/" -i configure.ac db/configure.ac || die
	eautoreconf
}

src_configure() {
	local myeconfargs=(
		--disable-static
		--with-config-dir="${EPREFIX}"/etc/${PN}
		--with-default-config-file="${EPREFIX}"/etc/${PN}/${PN}.conf
		--with-database-dir="${EPREFIX}"/var/lib/${PN}/db
		--with-cgi-bin-dir="${EPREFIX}"/var/www/localhost/cgi-bin
		--with-search-dir="${EPREFIX}"/var/www/localhost/hldocs/${PN}
		--with-image-dir="${EPREFIX}"/var/www/localhost/hldocs/${PN}
		$(use_with ssl)
	)
	econf "${myeconfargs[@]}"
}

src_install () {
	default
	sed -i "s:${D}::g" \
		"${ED}"/etc/${PN}/${PN}.conf \
		"${ED}"/usr/bin/rundig \
		|| die "sed failed (removing \${D} from installed files)"

	keepdir "${EPREFIX}"/var/lib/${PN}/db

	# Symlink hlsearch so it can be easily found.
	dosym ../../var/www/localhost/cgi-bin/hlsearch /usr/bin/hlsearch

	# No static archives
	find "${D}" -name '*.la' -delete || die
}
