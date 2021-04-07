# Copyright 1999-2020 Gentoo Authors
# Copyright 2020 The Trinity Desktop Project
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

TRINITY_MODULE_NAME="tdebase"
TSM_EXTRACT_ALSO="translations/"
TSM_EXTRACT="tdeioslave"
inherit trinity-meta-2

DESCRIPTION="Generic Trinity TDEIOslaves"

IUSE="+hwlib ldap openexr samba sasl"

DEPEND="
	net-libs/rpcsvc-proto
	x11-libs/libXcursor
	ldap? ( net-nds/openldap )
	openexr? ( media-libs/openexr )
	samba? ( net-fs/samba )
	sasl? ( dev-libs/cyrus-sasl )"

RDEPEND="${DEPEND}
	~trinity-base/tdeeject-${PV}
	virtual/ssh"

src_configure() {
	local mycmakeargs=(
		-DWITH_XCURSOR=ON
		-DWITH_SAMBA="$(usex samba)"
		-DWITH_LDAP="$(usex ldap)"
		-DWITH_SASL="$(usex sasl)"
		-DWITH_OPENEXR="$(usex openexr)"
		-DWITH_TDEHWLIB="$(usex hwlib)"
	)

	trinity-meta-2_src_configure
}
