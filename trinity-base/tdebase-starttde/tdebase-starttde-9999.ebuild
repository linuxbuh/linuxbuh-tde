# Copyright 1999-2020 Gentoo Authors
# Copyright 2020 The Trinity Desktop Project
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

TRINITY_MODULE_NAME="tdebase"
TSM_EXTRACT="starttde README.pam INSTALL AUTHORS COPYING COPYING-DOCS tdm r14-xdg-update migratekde3"
inherit trinity-meta-2

DESCRIPTION="Starttde script, which starts a complete Trinity session, and associated scripts"

RDEPEND="x11-apps/xmessage
	x11-apps/xsetroot
	x11-apps/xset
	x11-apps/xrandr
	x11-apps/mkfontscale
	x11-apps/xprop
	~trinity-base/kdesktop-${PV}
	~trinity-base/kcminit-${PV}
	~trinity-base/ksmserver-${PV}
	~trinity-base/twin-${PV}
	~trinity-base/kpersonalizer-${PV}
	~trinity-base/kreadconfig-${PV}
	~trinity-base/ksplashml-${PV}
	~trinity-base/tdeinit-${PV}"

src_prepare() {
	trinity-base-2_src_prepare
}

src_configure() {
	echo -n "";
}

src_compile() {
	# List all the multilib libdirs
	local _libdir _libdirs
	for _libdir in $(get_all_libdirs); do
		_libdirs="${_libdirs}:${TDEDIR}/${_libdir}"
	done
	_libdirs=${_libdirs#:}
}

src_install() {
	# starttde script
	exeinto "${TDEDIR}/bin"
	doexe starttde
	doexe r14-xdg-update
	doexe migratekde3

	# startup and shutdown scripts
	exeinto "${TDEDIR}/env"
	doexe "${FILESDIR}/agent-startup.sh"

	exeinto "${TDEDIR}/shutdown"
	doexe "${FILESDIR}/agent-shutdown.sh"

	# x11 session script
	cat <<EOF > "${T}/tde-${SLOT}"
#!/bin/sh
exec ${TDEDIR}/bin/starttde
EOF
	exeinto /etc/X11/Sessions
	doexe "${T}/tde-${SLOT}" # FIXME: change script branding to trinity

	# (not really) freedesktop compliant session script
	sed -e "s:@TDE_BINDIR@:${TDEDIR}/bin:g;s:Name=Trinity:Name=Trinity ${SLOT}:" \
		"${S}/tdm/kfrontend/sessions/tde.desktop.in" > "${T}/tde-${SLOT}.desktop"
	insinto /usr/share/xsessions
	doins "${T}/tde-${SLOT}.desktop"
}

pkg_postinst () {
	echo
	elog "To enable gpg-agent and/or ssh-agent in Trinity sessions,"
	elog "edit ${TDEDIR}/env/agent-startup.sh and"
	elog "${TDEDIR}/shutdown/agent-shutdown.sh"
	echo
}
