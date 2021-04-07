# Copyright 1999-2020 Gentoo Authors
# Copyright 2020 The Trinity Desktop Project
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

SRCTYPE="free" # TODO: what is it doing?
TQTBASE="/usr/tqt3" # TODO: no eclass var, get rid of prefixing
inherit eutils toolchain-funcs

if [[ ${PV} == *9999* ]]; then
	EGIT_REPO_URI="https://mirror.git.trinitydesktop.org/gitea/TDE/tqt3"
	inherit git-r3
else
	SRC_URI="http://mirror.ppa.trinitydesktop.org/trinity/releases/R${PV}/main/dependencies/tqt3-trinity-${PV}.tar.xz"
	S="${WORKDIR}/tqt3-trinity-${PV}"
	KEYWORDS="~amd64 ~x86"
fi

DESCRIPTION="Trinity's Qt3 fork - a comprehensive C++ application development framework"
HOMEPAGE="https://trinitydesktop.org/"

LICENSE="|| ( GPL-2 GPL-3 )"
SLOT="3.5"
IUSE="cups debug doc examples firebird fontconfig glib +hiddenvisibility imext ipv6
	mng mysql nas nis +opengl postgres sqlite styles tablet +xinerama +xrandr"

# Don't use Gentoo mirrors
RESTRICT="mirror"

RDEPEND="
	media-libs/freetype
	media-libs/libpng:=
	sys-libs/zlib
	virtual/jpeg:=
	x11-libs/libICE
	x11-libs/libSM
	x11-libs/libX11
	x11-libs/libXcursor
	x11-libs/libXext
	x11-libs/libXft
	x11-libs/libXi
	x11-libs/libXmu
	x11-libs/libXrandr
	x11-libs/libXt
	cups? ( net-print/cups )
	firebird? ( dev-db/firebird )
	fontconfig? ( media-libs/fontconfig )
	glib? ( dev-libs/glib )
	mng? ( media-libs/libmng )
	mysql? ( virtual/mysql )
	nas? ( media-libs/nas )
	nis? ( net-libs/libnsl )
	opengl? ( virtual/opengl virtual/glu )
	postgres? ( dev-db/postgresql:= )
	sqlite? ( dev-db/sqlite:= )
	xinerama? ( x11-libs/libXinerama )
	xrandr? ( x11-libs/libXrandr )
"
DEPEND="${RDEPEND}
	x11-base/xorg-proto
"

pkg_setup() {
	if use imext; then
		ewarn
		ewarn "You are going to compile binary incompatible immodule for TQt. This means"
		ewarn "you have to recompile everything depending on TQt after you install it."
		ewarn "Be aware."
		ewarn
		ewarn "You can do that with: revdep-rebuild --library 'libtqt-mt.so.3'"
		ewarn "To use that command, you need to install app-portage/gentoolkit."
		ewarn
	fi

	export TQTDIR="${S}"

	CXX=$(tc-getCXX)
	if [[ ${CXX/g++/} != ${CXX} ]]; then
		PLATCXX="g++"
	elif [[ ${CXX/icpc/} != ${CXX} ]]; then
		PLATCXX="icc"
	else
		die "Unknown compiler ${CXX}."
	fi

	case ${CHOST} in
		*-freebsd*|*-dragonfly*)
			PLATNAME="freebsd" ;;
		*-openbsd*)
			PLATNAME="openbsd" ;;
		*-netbsd*)
			PLATNAME="netbsd" ;;
		*-darwin*)
			PLATNAME="darwin" ;;
		*-linux-*|*-linux)
			PLATNAME="linux" ;;
		*)
			die "Unknown CHOST, no platform choosed."
	esac

	if [[ "$CHOST" == *64* && "$PLATCXX" == "g++" ]]; then
		export PLATFORM="${PLATNAME}-${PLATCXX}-64"
	else
		export PLATFORM="${PLATNAME}-${PLATCXX}"
	fi
}

src_prepare() {
	# Apply user-provided patches
	eapply_user

	# Do not link with -rpath. See Gentoo bug #75181.
	find mkspecs -name qmake.conf | xargs \
		sed -i -e 's:QMAKE_RPATH.*:QMAKE_RPATH =:' || die

	# Make qmake.conf respect our flags and toolchain
	sed -i -e "s:QMAKE_CFLAGS_RELEASE.*=.*:QMAKE_CFLAGS_RELEASE=${CFLAGS}:" \
		   -e 's:QMAKE_CFLAGS\t\t=.*:QMAKE_CFLAGS =:' \
		   -e "s:QMAKE_CXXFLAGS_RELEASE.*=.*:QMAKE_CXXFLAGS_RELEASE=${CXXFLAGS}:" \
		   -e "s:QMAKE_LFLAGS_RELEASE.*=.*:QMAKE_LFLAGS_RELEASE=${LDFLAGS}:" \
		   -e "s:\<QMAKE_CC\>.*=.*:QMAKE_CC=$(tc-getCC):" \
		   -e "s:\<QMAKE_CXX\>.*=.*:QMAKE_CXX=$(tc-getCXX):" \
		   -e "s:\<QMAKE_LINK\>.*=.*:QMAKE_LINK=$(tc-getCXX):" \
		   -e "s:\<QMAKE_LINK_SHLIB\>.*=.*:QMAKE_LINK_SHLIB=$(tc-getCXX):" \
		   -e "s:\<QMAKE_STRIP\>.*=.*:QMAKE_STRIP=:" \
		"mkspecs/${PLATFORM}/qmake.conf" || die

	# Remove obsolete X11 and OpenGL searchpaths
	find mkspecs -name qmake.conf | xargs \
		sed -i -e 's:QMAKE_INCDIR_X11\t=.*:QMAKE_INCDIR_X11\t=:' \
			-e 's:QMAKE_LIBDIR_X11\t=.*:QMAKE_LIBDIR_X11\t=:' \
			-e 's:QMAKE_INCDIR_OPENGL\t=.*:QMAKE_INCDIR_OPENGL\t=:' \
			-e 's:QMAKE_LIBDIR_OPENGL\t=.*:QMAKE_LIBDIR_OPENGL\t=:' || die

	if use hiddenvisibility; then
		sed -i -e 's:QMAKE_CFLAGS =:QMAKE_CFLAGS = -fvisibility=hidden -fvisibility-inlines-hidden:' \
			"mkspecs/${PLATFORM}/qmake.conf" || die
	fi

	if [ $(get_libdir) != "lib" ] ; then
		sed -i -e "s:/lib$:/$(get_libdir):" \
			"mkspecs/${PLATFORM}/qmake.conf" || die
		sed -i -e "s:/usr/lib /lib:/usr/$(get_libdir) /$(get_libdir):" \
			"config.tests/unix/"*.test || die
		sed -i -e "s:/usr/lib /lib:/usr/$(get_libdir) /$(get_libdir):" \
			"config.tests/x11/"*.test || die
		sed -i -e "s:/lib /usr/lib:/$(get_libdir) /usr/$(get_libdir):" \
			"config.tests/unix/checkavail" || die
	fi

	sed -i -e "s:CXXFLAGS.*=:CXXFLAGS=${CXXFLAGS} :" \
		-e "s:LFLAGS.*=:LFLAGS=${LDFLAGS} :" \
		"qmake/Makefile.unix" || die

	# Remove docs from install if we don't need them
	use doc || sed -i -e '/INSTALLS.*=.*htmldocs/d' \
		"src/qt_install.pri" || die
}

src_configure() {
	export SYSCONF="${D}${TQTBASE}"/etc/settings

	# Let's just allow writing to these directories
	# during emerge as it makes TQt much happier.
	addwrite "${TQTBASE}/etc/settings"
	addwrite "${HOME}/.qt"

	# Common options
	myconf=" -sm -thread -stl -no-verbose -largefile -no-pch -inputmethod -qt-style-motif"
	myconf+=" $(echo -{qt-imgfmt-,system-lib}{jpeg,png}) -qt-gif -system-zlib"
	myconf+=" -platform ${PLATFORM} -xplatform ${PLATFORM}"
	myconf+=" -xft -xrender -xshape -xkb -xcursor -prefix ${TQTBASE}"
	myconf+=" -libdir ${TQTBASE}/$(get_libdir) -fast -no-sql-odbc"

	[ "$(get_libdir)" != "lib" ] && myconf+="${myconf} -L/usr/$(get_libdir)"

	# Optional options
	use nas		&& myconf+=" -system-nas-sound" || myconf+=" -no-nas-sound"
	use nis		&& myconf+=" -nis" || myconf+=" -no-nis"
	use xrandr	&& myconf+=" -xrandr" || myconf+=" -no-xrandr"
	use mng		&& myconf+=" -qt-imgfmt-mng -system-libmng" || myconf+=" -no-imgfmt-mng"
	use cups	&& myconf+=" -cups" || myconf+=" -no-cups"
	use opengl	&& myconf+=" -enable-module=opengl -no-dlopen-opengl" || myconf+=" -disable-opengl"
	use xinerama	&& myconf+=" -xinerama" || myconf+=" -no-xinerama"
	use ipv6	&& myconf+=" -ipv6" || myconf+=" -no-ipv6"
	use glib	&& myconf+=" -glibmainloop" || myconf+=" -no-glibmainloop"
	use fontconfig	&& myconf+=" -lfontconfig"

	use debug	&& myconf+=" -debug" || myconf+=" -release -no-g++-exceptions -no-exceptions"

	use mysql	&& myconf+=" -plugin-sql-mysql -I/usr/include/mysql -L/usr/$(get_libdir)/mysql" || myconf+=" -no-sql-mysql"
	use postgres	&& myconf+=" -plugin-sql-psql -I/usr/include/postgresql/server -I/usr/include/postgresql/pgsql -I/usr/include/postgresql/pgsql/server" || myconf+=" -no-sql-psql"
	use firebird    && myconf+=" -plugin-sql-ibase -I/opt/firebird/include" || myconf+=" -no-sql-ibase"
	use sqlite	&& myconf+=" -plugin-sql-sqlite -plugin-sql-sqlite3" || myconf+=" -no-sql-sqlite -no-sql-sqlite3"

	use imext	&& myconf+=" -inputmethod-ext" || myconf+=" -no-inputmethod-ext"
	use tablet	&& myconf+=" -tablet" || myconf+=" -no-tablet"

	# Don't build styles, except requested (Motif is mandatory for TDE)
	use styles	&& myconf+=" -plugin-style-cde -plugin-style-compact -plugin-style-motifplus -plugin-style-platinum -plugin-style-sgi -plugin-style-windows" || myconf+=" -no-style-cde -no-style-compact -no-style-motifplus -no-style-platinum -no-style-sgi -no-style-windows"

	export YACC='byacc -d'
	tc-export CC CXX
	export LINK="$(tc-getCXX)"

	./configure ${myconf} || die
}

src_compile() {
	# Compile TQt with TQmake and TQmoc
	emake src-qmake src-moc sub-src

	# Compile TQt plugins (if any selected)
	emake sub-plugins

	# Point to libs for the tools to build fine too
	export DYLD_LIBRARY_PATH="${S}/lib:${DYLD_LIBRARY_PATH}"
	export LD_LIBRARY_PATH="${S}/lib:${LD_LIBRARY_PATH}"

	# Compile TQDesigner (TQuic is needed by tdelibs), TQAssistant and friends (msg2tqm, qembed..)
	emake sub-tools

	# Compile examples and tutorials
	if use examples; then
		emake sub-tutorial sub-examples
	fi
}

src_install() {
	# Install TQt with all compiled before
	emake INSTALL_ROOT="${D}" install

	# Fix qmake.conf files
	find "${D}${TQTBASE}/mkspecs" -name qmake.conf | xargs \
		sed -i -e "s:\$(TQTDIR):${TQTBASE}:" || die

	# Fix pkgconfig location
	dodir /usr/$(get_libdir)
	mv "${D}${TQTBASE}/$(get_libdir)/pkgconfig" "${D}/usr/$(get_libdir)/" || die

	# List all the multilib libdirs
	local libdirs
	for alibdir in $(get_all_libdirs); do
		libdirs="${libdirs}:${TQTBASE}/${alibdir}"
	done

	# Set environment variables
	cat <<EOF > "${T}"/44tqt3
PATH=${TQTBASE}/bin
ROOTPATH=${TQTBASE}/bin
LDPATH=${libdirs:1}
MANPATH=${TQTBASE}/doc/man
EOF

	cat <<EOF > "${T}"/44-tqt3-revdep
SEARCH_DIRS="${TQTBASE}"
EOF

	insinto /etc/revdep-rebuild
	doins "${T}"/44-tqt3-revdep
	doenvd "${T}"/44tqt3

	if [ "${SYMLINK_LIB}" = "yes" ]; then
		dosym $(get_abi_LIBDIR ${DEFAULT_ABI}) ${TQTBASE}/lib
	fi

	keepdir ${TQTBASE}/etc/settings

	if use doc; then
		insinto ${TQTBASE}
		doins -r "${S}"/doc
	fi

	# Install example and tutorial sources
	if use examples; then
		find "${S}"/examples "${S}"/tutorial -name Makefile | \
			xargs sed -i -e "s:${S}:${TQTBASE}:g" || die

		cp -r "${S}"/examples "${D}"${TQTBASE}/ || die
		cp -r "${S}"/tutorial "${D}"${TQTBASE}/ || die
	fi

	# Misc build requirements
	sed -e "s:${S}:${TQTBASE}:g" \
		"${S}"/.qmake.cache > "${D}"${TQTBASE}/.qmake.cache || die
}

pkg_postinst() {
	echo
	elog "After rebuilding TQt, it can happen that TQt plugins (such as TQt/TDE styles,"
	elog "or widgets for the TQt designer) are no longer recognized.  If this situation"
	elog "occurs you should recompile the packages providing these plugins,"
	elog "and you should also make sure that TQt and its plugins were compiled with the"
	elog "same version of GCC.  Packages that may need to be rebuilt are, for instance,"
	elog "trinity-base/tdelibs and trinity-base/tdeartwork-styles."
	echo
}
