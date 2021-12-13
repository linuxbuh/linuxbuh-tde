# Copyright 1999-2020 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI="7"

inherit cmake-utils desktop flag-o-matic gnome2-utils

DESCRIPTION="Base package of the Trinity Desktop Environment (TDE)"
HOMEPAGE="http://trinitydesktop.org/"

if [[ ${PV} = 14.0.999 ]]; then
	inherit git-r3
        EGIT_REPO_URI="https://mirror.git.trinitydesktop.org/cgit/${PN}"
        EGIT_BRANCH="r14.0.x"
	EGIT_SUBMODULES=()
elif [[ ${PV} = 9999 ]]; then
	inherit git-r3
        EGIT_REPO_URI="https://mirror.git.trinitydesktop.org/cgit/${PN}"
	EGIT_SUBMODULES=()
else
	SRC_URI="https://mirror.git.trinitydesktop.org/cgit/${PN}/snapshot/${PN}-r${PV}.tar.gz"
fi

LICENSE="GPL-2 LGPL-2"
SLOT="0"
KEYWORDS="~arm ~arm64 ~x86 ~amd64"
IUSE+=" -arts +pam avahi samba ldap +xdmcp +dbus +opengl +openexr xscreensaver +upower +tsak  xinerama +sensors +xrandr +xrender +xtest elficon +xcomposite elogind"

BDEPEND="
	~trinity-base/tde-common-cmake-${PV}
"
DEPEND="
	>=dev-qt/tqtinterface-${PV}
	sys-libs/libraw1394
	openexr? ( media-libs/openexr )
	dev-libs/libbsd
	xscreensaver? ( x11-misc/xscreensaver
			x11-libs/libXScrnSaver )
	opengl? ( dev-qt/tqtinterface[opengl] )
	ldap? ( net-nds/openldap )
	sensors? ( sys-apps/lm-sensors )
	net-libs/libtirpc
	net-libs/libnsl
	arts? ( trinity-base/arts )
	samba? ( net-fs/samba )
	tsak? ( virtual/libudev )
	xrandr? ( x11-libs/libXrandr )
	xinerama? ( x11-libs/libXinerama )
	upower? ( sys-power/upower )
	avahi? ( trinity-base/avahi-tqt )
	dbus? ( sys-apps/dbus
		dev-libs/dbus-tqt
		dev-libs/dbus-1-tqt )
	elficon? ( trinity-apps/libr
		~trinity-base/tdelibs-${PV}[elficon] )
	media-libs/libart_lgpl
	x11-base/xorg-server
	x11-apps/setxkbmap
	x11-libs/libXdamage
	sys-apps/usbutils
	sys-apps/usbutils
	x11-libs/libfontenc
	x11-base/xorg-proto
	x11-apps/bdftopcf
	~trinity-base/tdelibs-${PV}
	dev-libs/libconfig
	dev-libs/cyrus-sasl
	dev-libs/libgamin
	dev-libs/glib:2
	x11-libs/libxcb
	x11-libs/libX11
	x11-libs/libXtst
	media-libs/libsndfile
	net-libs/libasyncns
	media-gfx/graphite2
	x11-libs/libXfixes
	x11-libs/libXau
	xdmcp? ( x11-libs/libXdmcp )
	media-libs/flac
	media-libs/libogg
	media-libs/libvorbis
	x11-libs/libSM
	net-dns/libidn
	sys-apps/acl
	virtual/libusb:0
	net-libs/rpcsvc-proto
	xcomposite? ( x11-libs/libXcomposite
		~trinity-base/tdelibs-${PV}[xcomposite] )
"
RDEPEND="$DEPEND"

if [[ ${PV} = 14.0.999 ]] || [[ ${PV} = 9999 ]]; then
	S="${WORKDIR}/${P}"
else
	S="${WORKDIR}/${PN}-r${PV}"
fi

TQT="/usr/tqt3"
TDEDIR="/usr/trinity/14"

src_prepare() {
#	epatch ${FILESDIR}/one.patch
	# no compton
#	sed -i "twin/CMakeLists.txt" -e "/compton-tde/ s/^/#/"
	sed -i "${S}/tdm/kfrontend/gentdmconf.c" -e "s|/etc/X11/Xsession|/etc/trinity/X11/Xsession|"
	cmake-utils_src_prepare
}

src_configure() {
	cp -rf ${TDEDIR}/share/cmake .
	unset TDE_FULL_SESSION TDEROOTHOME TDE_SESSION_UID TDEHOME TDE_MULTIHEAD
	export PKG_CONFIG_PATH=$PKG_CONFIG_PATH:${TDEDIR}/$(get_libdir)/pkgconfig
	export LD_LIBRARY_PATH={$LD_LIBRARY_PATH}:${TDEDIR}/$(get_libdir)
	if use elficon ; then
		CXXFLAGS="${CXXFLAGS} -lr"
	fi
	mycmakeargs=(
		-DCMAKE_BUILD_TYPE="RelWithDebInfo"
#		-DCMAKE_INSTALL_PREFIX=${TDEDIR}
                -DCMAKE_C_FLAGS="${CFLAGS} -lbsd -L${TQT}/lib $(pkg-config --cflags --libs libtirpc)"
                -DCMAKE_CXX_FLAGS="${CXXFLAGS} -lbsd -L${TQT}/lib $(pkg-config --cflags --libs libtirpc)"
		-DCMAKE_SKIP_RPATH=OFF
		-DCMAKE_INSTALL_RPATH="${TDEDIR}/$(get_libdir)"
		-DCMAKE_VERBOSE_MAKEFILE=ON
		-DWITH_GCC_VISIBILITY=OFF

		-DBIN_INSTALL_DIR="${TDEDIR}/bin"
		-DINCLUDE_INSTALL_DIR="${TDEDIR}/include"
		-DLIB_INSTALL_DIR="${TDEDIR}/$(get_libdir)"
		-DSHARE_INSTALL_PREFIX="${TDEDIR}/share"
		-DCONFIG_INSTALL_DIR="/etc/trinity"
		-DSYSCONF_INSTALL_DIR="/etc/trinity"
		-DXDG_MENU_INSTALL_DIR="/etc/xdg/menus"

		-DWITH_ALL_OPTIONS=ON
		-DWITH_SASL=ON
		-DWITH_LDAP=$(usex ldap)
		-DWITH_SAMBA=$(usex samba)
#		-DWITH_OPENEXR=OFF  #flag
		-DWITH_OPENEXR=$(usex openexr)
		-DWITH_XCOMPOSITE=$(usex  xcomposite ON OFF)
		-DWITH_XCURSOR=ON
		-DWITH_XFIXES=ON
#  %{?!with_xrandr:-DWITH_XRANDR=OFF}
		-DWITH_XRANDR=$(usex xrandr)
		-DWITH_XRENDER=$(usex xrender)
#  %{?!with_libconfig:-DWITH_LIBCONFIG=OFF} \
		-DWITH_PCRE=ON
# %{?!with_xtest:-DWITH_XTEST=OFF} \
		-DWITH_XTEST=$(usex xtest)
		-DWITH_OPENGL=$(usex opengl)
#  %{?!with_xscreensaver:-DWITH_XSCREENSAVER=OFF} \
#  %{?!with_libart:-DWITH_LIBART=OFF} \
		-DWITH_XSCREENSAVER=$(usex xscreensaver)
		-DWITH_LIBUSB=ON
		-DWITH_LIBRAW1394=ON
		-DWITH_SUDO_TDESU_BACKEND=OFF
		-DWITH_SUDO_KONSOLE_SUPER_USER_COMMAND=OFF
#		-DWITH_PAM=ON
		-DWITH_USBIDS="/usr/share/misc/usb.ids"
		-DWITH_XDMCP=$(usex xdmcp)
		-DWITH_XINERAMA=$(usex xinerama)
		-DWITH_ARTS=$(usex arts)
		-DWITH_I8K=ON
		-DWITH_SENSORS=$(usex sensors)
#		{?with_hal:-DWITH_HAL=ON} \
#		%{?!with_tdehwlib:-DWITH_TDEHWLIB=OFF} \
		-DWITH_TDEHWLIB=$(usex tsak)
		-DWITH_UPOWER=$(usex upower)
#		 %{?!with_elficon:-DWITH_ELFICON=OFF} \
		-DWITH_ELFICON=$(usex elficon ON OFF)

		-DBUILD_ALL=ON
		-DBUILD_TSAK=$(usex tsak)
#		%{!?with_kbdledsync:-DBUILD_TDEKBDLEDSYNC=OFF} \
#		%{!?with_tsak:-DBUILD_TSAK=OFF} \
#		%if 0%{?fedora} >= 22 || 0%{?suse_version} >= 1320
		-DBUILD_TDEKBDLEDSYNC=ON
		-DHTDIG_SEARCH_BINARY="/usr/bin/htdig"


#		-DCMAKE_CXX_FLAGS="-L${TQT}/lib"
#		-DCMAKE_INSTAL_PREFIX=${TDEDIR}
	)

	if use pam ; then
	mycmakeargs+=(
		-DWITH_PAM=ON
		-DWITH_SHADOW=OFF
		-DKCHECKPASS_PAM_SERVICE="kcheckpass-trinity"
		-DTDM_PAM_SERVICE="tdm-trinity"
		-DTDESCREENSAVER_PAM_SERVICE="tdescreensaver-trinity"
	)
	else
	 mycmakeargs+=(
                -DWITH_PAM=OFF
                -DWITH_SHADOW=ON
	)
	fi

	 cmake-utils_src_configure
}

src_install() {
	cmake-utils_src_install
	if use pam ; then
		dodir /etc/pam.d
		insinto /etc/pam.d
		doins ${FILESDIR}/{kcheckpass-trinity,tdescreensaver-trinity,tdm-trinity}
		if use elogind ; then
			echo "session optional pam_elogind.so" >>${D}/etc/pam.d/tdm-trinity
		fi
	fi
	insinto /etc/trinity/X11
	doins ${FILESDIR}/Xsession
	dodir ${TDEDIR}/share/config/tdm
}

pkg_postinst() {
	if ! [ -f ${TDEDIR}/share/config/tdm/Xsession ] ; then
	gentdmconf
	fi
}
