# Copyright 1999-2020 Gentoo Authors
# Copyright 2020 The Trinity Desktop Project
# Distributed under the terms of the GNU General Public License v2

EAPI="7"
TRINITY_SUBMODULE="lanbrowsing"

TRINITY_MODULE_NAME="tdenetwork"
inherit trinity-meta-2

DESCRIPTION="Trinity Lan Information Server - allows to share information over a network."

src_install() {
	trinity-meta-2_src_install

	chmod u+s "${D}/${KDEDIR}/bin/reslisa"

	# lisa, reslisa initscripts
	sed -e "s:_TDEDIR_:${TDEDIR}:g" "${FILESDIR}/lisa" > "${T}/lisa"
	sed -e "s:_TDEDIR_:${TDEDIR}:g" "${FILESDIR}/reslisa" > "${T}/reslisa"
	doinitd "${T}/lisa" "${T}/reslisa"

	newconfd "${FILESDIR}/lisa.conf" lisa
	newconfd "${FILESDIR}/reslisa.conf" reslisa

	echo '# Default lisa configfile' > "$D/etc/lisarc"
	echo '# Default reslisa configfile' > "$D/etc/reslisarc"
}
