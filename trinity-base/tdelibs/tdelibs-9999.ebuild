# Copyright 1999-2020 Gentoo Authors
# Copyright 2020 The Trinity Desktop Project
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

TRINITY_MODULE_NAME="tdelibs"
inherit eapi8-dosym trinity-base-2

DESCRIPTION="Trinity libraries needed by all TDE programs"
HOMEPAGE="https://trinitydesktop.org/"

LICENSE="|| ( GPL-2 GPL-3 )"
SLOT="14"
if [[ ${PV} != *9999* ]] ; then
	KEYWORDS="~amd64 ~x86"
fi

# NOTE: Building without tdehwlib segfaults, but you can try and report.
IUSE="alsa arts cryptsetup cups debug elficons elogind fam +hwlib +idn jpeg2k
	kernel_linux libressl lua lzma malloc networkmanager openexr +pcre pcsc-lite
	pkcs11 +shm spell +ssl sudo +svg systemd tiff udevil udisks upower utempter
	xcomposite +xrandr zeroconf"

DEPEND="
	app-text/ghostscript-gpl
	~dev-libs/dbus-1-tqt-${PV}
	dev-libs/libxslt
	dev-libs/libxml2
	~dev-tqt/tqtinterface-${PV}
	media-libs/fontconfig
	media-libs/freetype
	x11-libs/libXrender
	alsa? ( media-libs/alsa-lib )
	arts? ( ~trinity-base/arts-${PV} )
	cups? ( net-print/cups )
	debug? ( sys-libs/binutils-libs:= )
	elficons? ( ~dev-libs/libr-${PV} )
	fam? ( virtual/fam )
	hwlib? ( virtual/libudev:= )
	idn? ( net-dns/libidn )
	jpeg2k? ( media-libs/jasper )
	lua? ( dev-lang/lua:* )
	lzma? ( app-arch/xz-utils )
	openexr? ( media-libs/openexr )
	pcre? ( dev-libs/libpcre )
	shm? ( x11-libs/libxshmfence )
	spell? ( app-text/aspell )
	ssl? (
		app-misc/ca-certificates
		!libressl? ( dev-libs/openssl:= )
		libressl? ( dev-libs/libressl:= )
	)
	sudo? ( app-admin/sudo )
	svg? ( media-libs/libart_lgpl )
	tiff? ( media-libs/tiff:= )
	utempter? ( sys-libs/libutempter )
	xcomposite? ( x11-libs/libXcomposite )
	xrandr? ( x11-libs/libXrandr )
	zeroconf? ( ~dev-tqt/avahi-tqt-${PV} )
"
RDEPEND="${DEPEND}
	hwlib? (
		acct-group/plugdev
		!udevil? ( !udisks? ( sys-apps/pmount ) )
		cryptsetup? ( sys-fs/cryptsetup )
		elogind? ( sys-auth/elogind )
		networkmanager? ( net-misc/networkmanager )
		pcsc-lite? ( sys-apps/pcsc-lite )
		pkcs11? ( dev-libs/pkcs11-helper )
		systemd? ( sys-apps/systemd )
		udevil? ( sys-apps/udevil )
		udisks? ( sys-fs/udisks:2 )
		upower? ( sys-power/upower )
	)
"

src_configure() {
	local enable_logind="OFF"
	if use systemd || use elogind; then
		enable_logind="ON"
	fi

	local mycmakeargs=(
		-DTDE_MALLOC="$(usex malloc)"
		-DTDE_MALLOC_FULL="$(usex malloc)"
		-DTDE_MALLOC_DEBUG="$(usex debug)"
		-DWITH_HSPELL=OFF
		-DWITH_HAL=OFF
		-DWITH_DEVKITPOWER=OFF
		-DWITH_OLD_XDG_STD=OFF
		-DWITH_KDE4_MENU_SUFFIX=OFF
		-DWITH_UDISKS=OFF
		-DWITH_ARTS="$(usex arts)"
		-DWITH_LIBIDN="$(usex idn)"
		-DWITH_MITSHM="$(usex shm)"
		-DWITH_PCRE="$(usex pcre)"
		-DWITH_LIBART="$(usex svg)"
		-DWITH_SSL="$(usex ssl)"
		-DWITH_LIBBFD="$(usex debug)"
		-DWITH_ELFICON="$(usex elficons)"
		-DWITH_TDEHWLIB="$(usex hwlib)"
		-DWITH_TDEHWLIB_DAEMONS="$(usex hwlib)"
		-DWITH_UDISKS2="$(usex udisks)"
		-DWITH_UDEVIL="$(usex udevil)"
		-DWITH_ALSA="$(usex alsa)"
		-DWITH_AVAHI="$(usex zeroconf)"
		-DWITH_CRYPTSETUP="$(usex cryptsetup)"
		-DWITH_CUPS="$(usex cups)"
		-DWITH_INOTIFY="$(usex kernel_linux)"
		-DWITH_JASPER="$(usex jpeg2k)"
		-DWITH_LUA="$(usex lua)"
		-DWITH_LZMA="$(usex lzma)"
		-DWITH_OPENEXR="$(usex openexr)"
		-DWITH_PCSC="$(usex pcsc-lite)"
		-DWITH_ASPELL="$(usex spell)"
		-DWITH_GAMIN="$(usex fam)"
		-DWITH_TIFF="$(usex tiff)"
		-DWITH_UTEMPTER="$(usex utempter)"
		-DUTEMPTER_HELPER="/usr/sbin/utempter"
		-DWITH_UPOWER="$(usex upower)"
		-DWITH_PKCS="$(usex pkcs11)"
		-DWITH_CONSOLEKIT=OFF
		-DWITH_LOGINDPOWER="${enable_logind}"
		-DWITH_NETWORK_MANAGER_BACKEND="$(usex networkmanager)"
		-DWITH_XCOMPOSITE="$(usex xcomposite)"
		-DWITH_XRANDR="$(usex xrandr)"
		-DWITH_SUDO_TDESU_BACKEND="$(usex sudo)"
		-DWITH_TDEICONLOADER_DEBUG="$(usex debug)"
	)

	trinity-base-2_src_configure
}

src_install() {
	trinity-base-2_src_install

	if use ssl; then
		# Make TDE to use our system certificates
		rm -f "${D}"${TDEDIR}/share/apps/kssl/ca-bundle.crt || die
		dosym8 -r /etc/ssl/certs/ca-certificates.crt ${TDEDIR}/share/apps/kssl/ca-bundle.crt
	fi

	dodir /etc/env.d
	# TDE expects that the install path is listed first in TDEDIRS and the user
	# directory (implicitly added) is the last entry. Doing otherwise breaks
	# certain functionality. Do not break this (once again *sigh*), but read the code.
	# TDE saves the installed path implicitly and so this is not needed, /usr
	# is set in ${TDEDIR}/share/config/kdeglobals and so TDEDIRS is not needed.

	# List all the multilib libdirs
	local libdirs pkgconfigdirs
	for libdir in $(get_all_libdirs); do
		libdirs="${TDEDIR}/${libdir}:${libdirs}"
	done
	libdirs+="${TDEDIR}/$(get_libdir)/trinity"

	cat <<EOF >"${D}/etc/env.d/45trinitypaths-${SLOT}" # number goes down with version upgrade
PATH=${TDEDIR}/bin
ROOTPATH=${TDEDIR}/sbin:${TDEDIR}/bin
LDPATH=${libdirs#:}
MANPATH=${TDEDIR}/share/man
CONFIG_PROTECT="${TDEDIR}/share/config ${TDEDIR}/env ${TDEDIR}/shutdown /usr/share/config"
XDG_DATA_DIRS="${TDEDIR}/share"
PKG_CONFIG_PATH="${TDEDIR}/$(get_libdir)/pkgconfig"
EOF

	# Make sure the target for the revdep-rebuild stuff exists. Fixes bug 184441.
	dodir /etc/revdep-rebuild

cat <<EOF >"${D}/etc/revdep-rebuild/50-trinity-${SLOT}"
SEARCH_DIRS="${TDEDIR}/bin ${TDEDIR}/lib*"
EOF

	trinity-base-2_create_tmp_docfiles
	trinity-base-2_install_docfiles
}

pkg_postinst () {
	if use sudo; then
		echo
		einfo "Remember that the sudo use flag sets only the default superuser command."
		einfo "It can be overriden on a user-level by adding:"
		einfo "  [super-user-command]"
		einfo "    super-user-command=su"
		einfo "to the kdeglobals config file, which is usually"
		einfo "located in the ~/.trinity/share/config/ directory."
		echo
	fi
	if use malloc; then
		echo
		einfo "You have build TDE with its own malloc implementation."
		einfo "That might result in better memory use for you when using TDE."
		einfo "But it could also result in a slightly different performance."
		einfo "With Gentoo you are free to choose what works better for you."
		einfo "If you remove the malloc USE flag, GLIBC's malloc will be used."
		echo
	fi
	if ! use hwlib; then
		for flag in networkmanager upower systemd elogind udisks udevil pkcs11 pcsc-lite cryptsetup; do
			use $flag && \
				echo
				ewarn "USE=\"$flag\" is passed, but it doesn't change anything because" && \
				ewarn "$flag support in ${P} takes effect only if the TDE hwlib is enabled."
				echo
		done

	fi
	if use hwlib; then
		echo
		einfo "Please add your user to the plugdev group to be able"
		einfo "to use the features of the TDE hwlibdaemons like suspend."
		echo
	fi
}
