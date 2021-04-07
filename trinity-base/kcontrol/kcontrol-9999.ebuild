# Copyright 1999-2020 Gentoo Authors
# Copyright 2020 The Trinity Desktop Project
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

TRINITY_MODULE_NAME="tdebase"
TSM_EXTRACT_ALSO="kicker/ twin/ kdesktop/ klipper/ kxkb/ translations/"
inherit trinity-meta-2

DESCRIPTION="The Trinity Control Center"

IUSE="+hwlib ieee1394 logitech-mouse samba +svg +xrandr"

DEPEND="
	~trinity-base/kicker-${PV}
	~trinity-base/libkonq-${PV}
	~trinity-base/tdelibs-${PV}[xrandr?]
	x11-libs/libX11
	x11-libs/libXcursor
	x11-libs/libXrender
	ieee1394? ( sys-libs/libraw1394 )
	logitech-mouse? ( virtual/libusb:0 )
	samba? ( net-fs/samba )
"
RDEPEND="${DEPEND}
	sys-apps/usbutils
	~trinity-base/kcminit-${PV}
	~trinity-base/khelpcenter-${PV}
	~trinity-base/khotkeys-${PV}
	~trinity-base/tdebase-data-${PV}
	~trinity-base/tdesu-${PV}
	svg? ( media-libs/libart_lgpl )
"

src_configure() {
	local mycmakeargs=(
		-DWITH_XCURSOR=ON
		-DWITH_XRENDER=ON
		-DWITH_USBIDS=/usr/share/misc/usb.ids
		-DWITH_SAMBA="$(usex samba)"
		-DWITH_LIBUSB="$(usex logitech-mouse)"
		-DWITH_LIBRAW1394="$(usex ieee1394)"
		-DWITH_XRANDR="$(usex xrandr)"
		-DWITH_TDEHWLIB="$(usex hwlib)"
		-DWITH_LIBART="$(usex svg)"
		-DXSCREENSAVER_DIR="/usr/$(get_libdir)/misc/xscreensaver"
	)

	trinity-meta-2_src_configure
}
