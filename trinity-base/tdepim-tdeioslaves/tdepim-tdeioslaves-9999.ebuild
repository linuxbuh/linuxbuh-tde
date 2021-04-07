# Copyright 1999-2020 Gentoo Authors
# Copyright 2020 The Trinity Desktop Project
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

TRINITY_MODULE_NAME="tdepim"
TRINITY_SUBMODULE="tdeioslave"
TSM_EXTRACT_ALSO="libtdepim/ libemailfunctions/ libkmime/ translations/"
inherit trinity-meta-2

DESCRIPTION="PIM Trinity TDEIOslaves"

if [[ ${PV} != *9999* ]] ; then
	KEYWORDS="~amd64 ~x86"
fi

IUSE="sasl sieve"

# The Sieve TDEIOslave won't build without SASL and
# the IMAP4 TDEIOslave will lose the ability of SASL
# authentification. To fulfill any expectation of users,
# we offer two USE flags, which depend on each other.

REQUIRED_USE="
	sasl? ( sieve )
	sieve? ( sasl )
"

DEPEND="
	net-libs/libtirpc
	~trinity-base/libkmime-${PV}
	sasl? ( dev-libs/cyrus-sasl )"
RDEPEND="${DEPEND}"

src_configure() {
	local mycmakeargs=(
		-DWITH_SASL=$(usex sieve)
	)
	trinity-meta-2_src_configure
}
