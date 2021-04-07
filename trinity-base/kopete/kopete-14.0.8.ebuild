# Copyright 1999-2017 Gentoo Foundation
# Copyright 2020 The Trinity Desktop Project
# Distributed under the terms of the GNU General Public License v2

EAPI="7"
TRINITY_MODULE_NAME="tdenetwork"

inherit trinity-meta-2

DESCRIPTION="Trinity multi-protocol IM client"
KEYWORDS="~amd64 ~x86"

IUSE="jingle gsmlib netmeeting speex kernel_linux"
PLUGINS="latex autoreplace history contactnotes crypt connectionstatus
	translator nowlistening webpresence texteffect highlight alias
	motionautoaway netmeeting addbookmarks statistics smpppdcs"
PROTOCOLS="gadu groupwise irc xmpp oscar msn sms sametime winpopup yahoo"
# unsupported USE="v4l2 opengl xscreensaver ssl emoticons-manager "
# USE=xmms works only with xmms1
IUSE="${IUSE} ${PLUGINS} ${PROTOCOLS}"
REQUIRED_USE="
	jingle? ( xmpp )
	gsmlib? ( sms )
	netmeeting? ( msn )
	speex? ( jingle xmpp )"

# MISSING BOTH_DEPEND
#	x11-libs/libXrender
#	xmpp? ( net-dns/libidn )
#	kernel_linux? ( virtual/opengl )
#	opengl? ( dev-qt/qt-meta[opengl] )
#	xscreensaver? ( x11-libs/libXScrnSaver )
#	xmpp|groupwice? =app-crypt/qca-1.0*
BOTH_DEPEND="
	jingle? ( dev-libs/glib )
	netmeeting? ( dev-libs/glib )
	webpresence? (
		dev-libs/libxml2
		dev-libs/libxslt )
	jingle? (
		dev-libs/expat
		speex? ( media-libs/speex )
	)
	gsmlib? ( app-mobilephone/gsmlib )
	gadu? ( net-libs/libgadu )
	sametime? ( net-libs/meanwhile )
	media-libs/libv4l
"

# MISSING DEPEND
#	x11-proto/videoproto
#	kernel_linux? (
#		x11-libs/libXv
#	)
#	xscreensaver? ( x11-proto/scrnsaverproto )
DEPEND="${BOTH_DEPEND}
	kernel_linux? (
		virtual/os-headers
	)
"

# MISSING RDEPEND
#     netmeeting? ( net-voip/ekiga )
#     ssl? ( =app-crypt/qca-tls-1.0* )
RDEPEND="${BOTH_DEPEND}
	crypt? ( app-crypt/gnupg )
	latex? (
		media-gfx/imagemagick
		virtual/latex-base )
	sms? ( !gsmlib? ( || (
				app-mobilephone/smsclient
				app-mobilephone/smssend	) ) )
"

src_configure() {
	mycmakeargs=(
		-DWITH_JINGLE="$(usex jingle)"
		-DWITH_GSM="$(usex gsmlib)"
		-DWITH_WEBCAM="$(usex netmeeting)"
		-DWITH_SPEEX="$(usex speex)"

		-DBUILD_KOPETE_PLUGIN_LATEX="$(usex latex)"
		-DBUILD_KOPETE_PLUGIN_AUTOREPLACE="$(usex autoreplace)"
		-DBUILD_KOPETE_PLUGIN_HISTORY="$(usex history)"
		-DBUILD_KOPETE_PLUGIN_CONTACTNOTES="$(usex contactnotes)"
		-DBUILD_KOPETE_PLUGIN_CRYPTOGRAPHY="$(usex crypt)"
		-DBUILD_KOPETE_PLUGIN_CONNECTIONSTATUS="$(usex connectionstatus)"
		-DBUILD_KOPETE_PLUGIN_TRANSLATOR="$(usex translator)"
		-DBUILD_KOPETE_PLUGIN_NOWLISTENING="$(usex nowlistening)"
		-DBUILD_KOPETE_PLUGIN_WEBPRESENCE="$(usex webpresence)"
		-DBUILD_KOPETE_PLUGIN_TEXTEFFECT="$(usex texteffect)"
		-DBUILD_KOPETE_PLUGIN_HIGHLIGHT="$(usex highlight)"
		-DBUILD_KOPETE_PLUGIN_ALIAS="$(usex alias)"
		-DBUILD_KOPETE_PLUGIN_MOTIONAUTOAWAY="$(usex motionautoaway)"
		-DBUILD_KOPETE_PLUGIN_NETMEETING="$(usex netmeeting)"
		-DBUILD_KOPETE_PLUGIN_ADDBOOKMARKS="$(usex addbookmarks)"
		-DBUILD_KOPETE_PLUGIN_STATISTICS="$(usex statistics)"
		-DBUILD_KOPETE_PLUGIN_SMPPPDCS="$(usex smpppdcs)"

		-DBUILD_KOPETE_PROTOCOL_GADU="$(usex gadu)"
		-DBUILD_KOPETE_PROTOCOL_GROUPWISE="$(usex groupwise)"
		-DBUILD_KOPETE_PROTOCOL_IRC="$(usex irc)"
		-DBUILD_KOPETE_PROTOCOL_JABBER="$(usex xmpp)"
		-DBUILD_KOPETE_PROTOCOL_OSCAR="$(usex oscar)"
		-DBUILD_KOPETE_PROTOCOL_MSN="$(usex msn)"
		-DBUILD_KOPETE_PROTOCOL_SMS="$(usex sms)"
		-DBUILD_KOPETE_PROTOCOL_MEANWHILE="$(usex sametime)"
		-DBUILD_KOPETE_PROTOCOL_WINPOPUP="$(usex winpopup)"
		-DBUILD_KOPETE_PROTOCOL_YAHOO="$(usex yahoo)"
	)

	trinity-meta-2_src_configure
}
