# Copyright 1999-2020 Gentoo Authors
# Copyright 2020 The Trinity Desktop Project
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

PYTHON_COMPAT=( python2_7 python3_{7,8,9})
inherit autotools eutils python-r1

DESCRIPTION="Lightweight, speed optimized color management engine"
HOMEPAGE="https://www.littlecms.com/"
SRC_URI="mirror://sourceforge/lcms/${PV}/${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~alpha amd64 arm arm64 hppa ~ia64 m68k ~mips ppc ppc64 s390 sparc x86 ~amd64-linux ~x86-linux ~ppc-macos ~x64-macos ~x86-macos ~m68k-mint ~sparc-solaris ~x64-solaris ~x86-solaris"
IUSE="jpeg python static-libs tiff zlib"

REQUIRED_USE="python? ( ${PYTHON_REQUIRED_USE} )"

# Don't use Gentoo mirrors
RESTRICT="mirror"

RDEPEND="
	jpeg? ( virtual/jpeg:0 )
	python? ( ${PYTHON_DEPS} )
	tiff? ( media-libs/tiff:0 )
	zlib? ( sys-libs/zlib )"
DEPEND="${RDEPEND}
	python? ( >=dev-lang/swig-1.3.31 )"

PATCHES=(
	"${FILESDIR}/${P}-disable_static_modules.patch"
	"${FILESDIR}/${P}-implicit.patch"
)

src_prepare() {
	# Python bindings are built/installed manually.
	sed -e "/SUBDIRS =/s/ python//" -i Makefile.am || die

	default

	eautoreconf

	# run swig to regenerate lcms_wrap.cxx and lcms.py (bug #148728)
	if use python; then
		cd python || die
		./swig_lcms || die "swig failed to regenerate files"
	fi
}

src_configure() {
	econf \
		--libdir="${EPREFIX}"/usr/$(get_libdir) \
		--bindir="${EPREFIX}"/usr/bin \
		--disable-dependency-tracking \
		$(use_enable static-libs static) \
		$(use_with jpeg) \
		$(use_with python) \
		$(use_with tiff) \
		$(use_with zlib)
}

src_compile() {
	default

	if use python; then
		local BUILD_DIR
		BUILD_DIR=python

		python_copy_sources

		building() {
			emake \
				LCMS_PYEXECDIR="${EPREFIX}$(python_get_sitedir)" \
				LCMS_PYINCLUDE="${EPREFIX}$(python_get_includedir)"
#               No corresponding functions in python-r1
#				LCMS_PYLIB="${EPREFIX}$(python_get_libdir)" \
#				PYTHON_VERSION="$(python_get_version)"
		}
		python_foreach_impl run_in_build_dir building
	fi
}

src_install() {
	DOCS=(AUTHORS README* INSTALL NEWS doc/*)

	default

	if use python; then
		local BUILD_DIR
		BUILD_DIR=python

		installation() {
			emake \
				DESTDIR="${D}" \
				LCMS_PYEXECDIR="${EPREFIX}$(python_get_sitedir)" \
				install
		}
		python_foreach_impl run_in_build_dir installation
	fi

	insinto /usr/share/lcms/profiles
	doins testbed/*.icm

	find "${ED}" -name '*.la' -delete || die
}
