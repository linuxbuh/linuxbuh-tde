# Copyright 1999-2020 Gentoo Authors
# Copyright 2020 The Trinity Desktop Project
# Distributed under the terms of the GNU General Public License v2

EAPI="7"

TRINITY_MODULE_NAME="tdeutils"
inherit trinity-meta-2

DESCRIPTION="Trinity gpg keyring manager"

KEYWORDS="~amd64 ~x86"

RDEPEND="app-crypt/gnupg
	|| (
		app-crypt/pinentry[ncurses]
		app-crypt/pinentry[qt5]
		app-crypt/pinentry[gtk]
		app-crypt/pinentry[tqt(-)]
	)"
