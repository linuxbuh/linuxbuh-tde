# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $


EAPI=6

inherit eutils

DESCRIPTION="Linuxbuh update Trinity Desktop Environment "
HOMEPAGE="http://linuxbuh.ru"
SRC_URI="https://github.com/linuxbuh/linuxbuh-tde-update-script/archive/refs/tags/0.1.tar.gz"

LICENSE="GPL"
SLOT="0"
KEYWORDS="-* amd64 x86"
IUSE=""

RESTRICT="mirror strip"

RDEPEND="x11-terms/xterm
	x11-misc/xdialog
	app-admin/sudo
	net-misc/wput"


src_install() {
cd ${WORKDIR}
mkdir -p ${D}/usr/share/linuxbuh-tde-update-script
mkdir -p ${D}/usr/share/linuxbuh-tde-update-script/txt
mkdir -p ${D}/usr/share/applications
mkdir -p ${D}/usr/share/pixmaps
mkdir -p ${D}/usr/bin

cp -r ${FILESDIR}/lb-tde-update-full.desktop ${D}/usr/share/applications/lb-tde-update-full.desktop
cp -r ${FILESDIR}/lb-tde-update-lang.desktop ${D}/usr/share/applications/lb-tde-update-lang.desktop
cp -r ${FILESDIR}/lb-tde-update-live.desktop ${D}/usr/share/applications/lb-tde-update-live.desktop
cp -r ${FILESDIR}/tde-logo.png ${D}/usr/share/pixmaps
cp -r ${WORKDIR}/${P}/lb-tde-update-full ${D}/usr/bin
cp -r ${WORKDIR}/${P}/lb-tde-update-lang ${D}/usr/bin
cp -r ${WORKDIR}/${P}/lb-tde-update-live ${D}/usr/bin

}


pkg_postinst() {

chmod 0777 /usr/bin/lb-tde-update-full
chmod 0777 /usr/bin/lb-tde-update-lang
chmod 0777 /usr/bin/lb-tde-update-live

nopasswd=`ls /etc/sudoers.d/ | grep nopasswd`

if [ nopasswd == $nopasswd ]; then
    echo "Файл nopasswd есть в каталоге"
    else
    touch /etc/sudoers.d/nopasswd
    echo "%wheel ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers.d/nopasswd
    echo "Файл nopasswd нет в каталоге"
    fi

}