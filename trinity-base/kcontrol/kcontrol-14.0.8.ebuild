# Copyright 1999-2020 Gentoo Authors
# Copyright 2020 The Trinity Desktop Project
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

TRINITY_MODULE_NAME="tdebase"
inherit trinity-meta-2

DESCRIPTION="The Trinity Control Center"

KEYWORDS="~amd64 ~x86"
IUSE="samba logitech-mouse ieee1394 +svg +hwlib +xrandr "

DEPEND="x11-libs/libX11
	x11-libs/libXrender
	x11-libs/libXcursor
	samba? ( net-fs/samba )
	logitech-mouse? ( dev-libs/libusb-compat )
	ieee1394? ( sys-libs/libraw1394 )
	~trinity-base/tdelibs-${PV}[xrandr?]
	~trinity-base/libkonq-${PV}
	~trinity-base/kicker-${PV}"

RDEPEND="${DEPEND}
	sys-apps/usbutils
	~trinity-base/kcminit-${PV}
	~trinity-base/tdebase-data-${PV}
	~trinity-base/tdesu-${PV}
	~trinity-base/khelpcenter-${PV}
	~trinity-base/khotkeys-${PV}
	svg? ( media-libs/libart_lgpl )"

TSM_EXTRACT_ALSO="kicker/ twin/ kdesktop/ klipper/ kxkb/"

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
